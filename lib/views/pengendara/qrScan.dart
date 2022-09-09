import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/mqtt_wait.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

class Kendaraan {
  Kendaraan(this.id, this.nama);
  String id;
  String nama;
}

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? id_pengguna;
  List<Kendaraan> listMotor = List.empty(growable: true);
  QueryResult? result;
  int _idKendaraan = 0;

  /// Dapatkan data kendaraan yang dimiliki oleh pengguna
  /// Jika kosong maka munculkan alert untuk menambahkan kendaraan lebih dulu
  /// Jika tidak kosong maka masukkan listMotor untuk memilih kendaraan
  Future<void> getMotor(BuildContext context) async {
    String id_pengguna = Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    
    const String motor = r'''
query loadKendaraan($id_pengguna: Int) {
  Kendaraans(id_pengguna: $id_pengguna) {
    nama
    id_kendaraan
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(document: gql(motor), variables: <String, dynamic>{"id_pengguna": int.parse(id_pengguna)});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    if (kDebugMode) {
      print('msg: $response');
    }
    if (response.length == 0) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, 
        builder: ((context) {
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
              )
            ],
          );
        }),
      );

      return;
    }
    
    for (var i = 0; i < response.length; i++) {
      listMotor.add(Kendaraan(response[i]['id_kendaraan'].toString(), response[i]['nama']));
    }
    if (listMotor.length == 1) {
      _idKendaraan = int.parse(listMotor[0].id);
    }
    setState(() {});
  }

  late Position _lokasi;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.'); }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // _lokasi = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      // forceAndroidLocationManager: true
    );
    _lokasi = position;
    return position;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  bool clicked = false;
  String idPengguna = '';

  @override
  void initState() {
    _determinePosition();
    Future.delayed(Duration.zero, () async {
      await getMotor(context);
      await controller?.flipCamera();
      await controller?.flipCamera();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    idPengguna = Provider.of<Person>(context, listen: false).id_pengguna.toString();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // _lokasi.latitude > 0 ? buildQrView(context) : const Center(child: CircularProgressIndicator()),
            FutureBuilder(builder: ((context, AsyncSnapshot<Position> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return buildQrView(context);
              }
              return const Center(child: CircularProgressIndicator());
            }), future: _determinePosition()),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.31,
                top: MediaQuery.of(context).size.width * 0.1,
                child: Center(
                  child: pickVehicle(),
                )),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.22,
                bottom: MediaQuery.of(context).size.width * 0.4,
                child: Center(child: buildResult()))
          ],
        ),
      ),
    );
  }

  Widget pickVehicle() => Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      // border: Border.all(color: Colors.white, width: 3),
      borderRadius: BorderRadius.circular(15)),
    width: MediaQuery.of(context).size.width * 0.375,
    height: MediaQuery.of(context).size.height * 0.07,
    child: ListView.builder(itemBuilder: ((context, index) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _idKendaraan = int.parse(listMotor[index].id);
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.36,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(52, 152, 219, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              // child: PickVehicleButton(name: listMotor[index].nama)
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      listMotor[index].nama,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  )
                ],
              )
            )
              // child: 
          ),
        ),
      ]);
    }), itemCount: listMotor.length, scrollDirection: Axis.horizontal),
  );
  Widget buildResult() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white24, borderRadius: BorderRadius.circular(8)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Arahkan TAEK Camera pada Qr Code'),
      ],
    ),
  );
  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: const Color.fromRGBO(52, 152, 219, 1),
      borderRadius: 10,
      borderLength: 20,
      borderWidth: 10,
      cutOutSize: MediaQuery.of(context).size.width * 0.7,
    ),
  );
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(((scanData) => setState(() {
      controller.pauseCamera();
      checkToServer(scanData.code);
    })));
  }

  checkToServer(String? data) async {
    if (data != null) {
      /// split data with / and then take the last item
      var splitData = data.split('/')[data.split('/').length - 1];
      if (kDebugMode) {
        print('msg: idparkiran: $splitData');
        print('msg: idpengguna: $idPengguna');
        print('msg: idkendaraan: $_idKendaraan');
        print('msg: lokasi: ${_lokasi.latitude},${_lokasi.longitude}');
      }
      
      try {
        var response = await Dio().post('${dotenv.env['API']!}/distance', data: {
          'id_parkiran': splitData,
          'origins': '${_lokasi.latitude},${_lokasi.longitude}',
          'id_pengguna': idPengguna,
          'id_kendaraan': _idKendaraan,
          'isTukangParkir': false
        });
        // ignore: unnecessary_brace_in_string_interps
        if (kDebugMode) {
          print('msg: $response');
        }
        
        if (response.data['message'] == 'Too Far') {
          // showDialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Terlalu Jauh'),
                content: const Text('Anda terlalu jauh dari parkiran. Silahkan dekatkan diri anda'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      controller?.resumeCamera();
                    },
                  ),
                ],
              );
            },
          );
          return;
        }
 
        if (response.data['message'] == 'Validated') {
          // auto validate parkiran di pengaturan, munculkan dialog success
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Berhasil'),
                content: const Text('Anda diperbolehkan masuk parkiran. Silakan parkir'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // redirect ke widget mainMenu
                      controller?.dispose();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            }
          );
          controller!.stopCamera();
          return;
        } else {
          if (kDebugMode) {
            print(response.data['message']);
          }
          // gunakan mqtt untuk mengetahui persetujuan tukang parkir
          controller!.dispose();
          if (mounted) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MqttWait(idParkir: int.parse(splitData), idKendaraan: _idKendaraan, nomorKendaraan: '',)));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
