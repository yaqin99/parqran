import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? data;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position lokasi;

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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    lokasi = await Geolocator.getCurrentPosition();
    print(lokasi.latitude);
    print(lokasi.longitude);

    return lokasi;
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

  @override
  void initState() {
    // TODO: implement initState
    getCamera();
    _determinePosition();

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: Stack(
          children: [
            buildQrView(context),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.22,
                bottom: MediaQuery.of(context).size.width * 0.4,
                child: Center(child: buildResult()))
          ],
        ),
      ));

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Arahkan Camera pada Qr Code '),
          ],
        ),
      );
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Color.fromRGBO(52, 152, 219, 1),
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(((scanData) => setState(() {
          this.data = scanData;

          controller.stopCamera();
          Navigator.pop(context);
        })));
    @override
    void dispose() {
      controller.dispose();

      super.dispose();
    }
  }
}
