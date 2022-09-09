import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/mqtt_wait.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:parqran/views/pengendara/qrScan.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanMasuk extends StatefulWidget {
  const ScanMasuk({Key? key}) : super(key: key);

  @override
  State<ScanMasuk> createState() => _ScanMasukState();
}

class _ScanMasukState extends State<ScanMasuk> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late Position _position;
  int _idKendaraan = 0;
  final List<Kendaraan> _kendaranList = List.empty(growable: true);

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _position = p; 
    return p;
  }

  // Dapatkan kendaraan yang dimiliki
  Future<void> _getKendaraan() async {
    String pengguna = Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    const String query = r'''
      query loadKendaraan($id_pengguna: Int) {
        Kendaraans(id_pengguna: $id_pengguna) {
          nama
          id_kendaraan
        }
      }
    ''';
    final QueryOptions queryOptions = QueryOptions(document: gql(query), variables: <String, dynamic>{'id_pengguna': int.parse(pengguna)});
    var rest = await Services.gqlQuery(queryOptions);
    var resp = rest.data!['Kendaraans'];
    if (kDebugMode) {
      print('msg: $resp');
    }

    // jika belum memiliki kendaraan
    if (resp.length == 0) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Peringatan'),
            content: const Text('Anda belum memiliki kendaraan'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }, 
                child: const Text('Tambah Kendaraan')
              ),
            ],
          );
        },
      );
    }

    // jika sudah memiliki kendaraan
    setState(() {
      for (var i = 0; i < resp.length; i++) {
        _kendaranList.add(Kendaraan(resp[i]['id_kendaraan'].toString(), resp[i]['nama']));
      }
      if (_kendaranList.length == 1) {
        _idKendaraan = int.parse(_kendaranList[0].id);
      }
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                //horizontal list to pick kendaraan
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _idKendaraan = int.parse(_kendaranList[index].id);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: _idKendaraan == int.parse(_kendaranList[index].id) ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(_kendaranList[index].nama, style: const TextStyle(
                            color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold
                          )),
                        ),
                      );
                    }), itemCount: _kendaranList.length, scrollDirection: Axis.horizontal),
                  ),
                ),
                const BottomInfo(),
              ],
            );
          } else {
            // loading indicator with searching location text
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }, future: _determinePosition()),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.flipCamera();
    controller.flipCamera();
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      if (kDebugMode) {
        print('result: ${result!.code}');
      }
      _checkToServer();
    });
  }

  void _checkToServer() async {
    String pengguna = Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    String split = result!.code!.split('/').last;
    if (kDebugMode) {
      print('msg: idparkiran: $split');
      print('msg: idpengguna: $pengguna');
      print('msg: idkendaraan: $_idKendaraan');
      print('msg: lokasi: ${_position.latitude},${_position.longitude}');
    }

    try {
      var resp = await Dio().post('${dotenv.env['API']!}/distance', data: {
        'id_parkiran': split,
        'id_pengguna': pengguna,
        'id_kendaraan': _idKendaraan,
        'origins': '${_position.latitude},${_position.longitude}',
      });
      if (kDebugMode) {
        print('msg: $resp');
      }
      
      if (resp.data['message'] == 'Too Far') {
        // showDialog
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Anda terlalu jauh dari parkiran. Silahkan dekatkan diri anda'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller!.resumeCamera();
                  }, 
                  child: const Text('OK')
                ),
              ],
            );
          },
        );
      }
      if (resp.data['message'] == 'Validated') {
        // auto validate parkiran di pengaturan, munculkan dialog
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Berhasil'),
              content: const Text('Anda diperbolehkan masuk parkiran. Silakan parkir'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    controller!.dispose();
                    // pindah ke MainMenu
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                  }, 
                  child: const Text('OK')
                ),
              ],
            );
          },
        );
        controller!.stopCamera();
        return;
      }

      // gunakan mqtt untuk memberitahu pemilik parkir
      controller!.dispose();
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MqttWait(idParkir: int.parse(split), idKendaraan: _idKendaraan, nomorKendaraan: resp.data['no_registrasi'])));
      }
    } catch (e) {
      if (kDebugMode) {
        print('msg: error: $e');
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getKendaraan();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

/// Bottom info widget
class BottomInfo extends StatelessWidget {
  const BottomInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Scan QR Code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Scan QR Code yang ada di Parkiran',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}