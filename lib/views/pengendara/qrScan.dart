import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/pickVehicleButton.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/person.dart';
import '../../model/services.dart';

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
  Barcode? data;
  String? id_pengguna;
  List<Kendaraan> listMotor = List.empty(growable: true);
  QueryResult? result;

  getMotor() async {
    final String id_pengguna = Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    
    const String motor = r'''
query loadKendaraan($id: Int) {
  Kendaraans(id: $id) {
    nama
    id_kendaraan
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(document: gql(motor), variables: <String, dynamic>{"id": id_pengguna});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    for (var item in response) {
      listMotor.add(Kendaraan(item['id_kendaraan'], item['nama']));
    }
    print(listMotor);
    setState(() {});
  }

  late Position _lokasi;
  Future<void> _determinePosition() async {
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
    _lokasi = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(_lokasi.latitude);
    print(_lokasi.longitude);
  }

  getCamera() async {
    await controller?.flipCamera();
    await controller?.flipCamera();
    print('getData Called');

    setState(() {});
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
    getCamera();
    _determinePosition();
    getMotor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    idPengguna = Provider.of<Person>(context, listen: false).id_pengguna.toString();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildQrView(context),
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
      )
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
        Container(
          width: MediaQuery.of(context).size.width * 0.36,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(52, 152, 219, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: PickVehicleButton(name: listMotor[index].nama))
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
          children: const [
            Text('Arahkan Camera pada Qr Code '),
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
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen(((scanData) => setState(() {
      data = scanData;
      controller.stopCamera();
      Navigator.pop(context);
    })));
  }

  checkToServer() async {
    if (data != null) {
      // if (_lokasi) {
      //   Timer timer = new Timer(const Duration(seconds: 5), () {
      //     _determinePosition()
      //   });
      // }
      try {
        await Dio().post('${dotenv.env['API']!}/distance', data: {
          'id_parkiran': data!.code,
          'origins': '${_lokasi.latitude},${_lokasi.longitude}',
          'id_pengguna': idPengguna,
          'id_kendaraan': '1'
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
