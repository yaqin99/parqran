import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  // void initState() {
  //   super.initState();
  //   controller!.resumeCamera();
  // }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: Stack(
          children: [
            buildQrView(context),
            Positioned(bottom: 10, child: buildResult())
          ],
        ),
      ));

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: Text(
          (barcode != null) ? 'Result : ${barcode!.code}' : 'Scan a Code',
          maxLines: 3,
        ),
      );
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        // overlay: QrScannerOverlayShape(
        //   //   //   borderColor: Color.fromRGBO(52, 152, 219, 1),
        //   //   //   borderRadius: 10,
        //   //   //   borderLength: 20,
        //   //   //   borderWidth: 10,
        //   cutOutWidth: MediaQuery.of(context).size.width * 0.7,
        //   cutOutHeight: MediaQuery.of(context).size.height * 0.7,
        // ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(((barcode) => setState(() {
          this.barcode = barcode;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainMenu();
          }));
        })));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
