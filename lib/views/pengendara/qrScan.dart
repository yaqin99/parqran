import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? data;

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
        body: GestureDetector(
          onTap: () async {
            setState(() {});
            clicked = true;
            print(clicked);
            await controller?.flipCamera();
            await controller?.flipCamera();
          },
          child: Stack(
            children: [
              buildQrView(context),
              // Positioned(
              //     bottom: 30,
              //     child: Container(
              //       margin: const EdgeInsets.all(8),
              //       child: ElevatedButton(
              //           onPressed: () async {
              //             setState(() {});
              //             await controller?.flipCamera();
              //             await controller?.flipCamera();
              //           },
              //           child: FutureBuilder(
              //             future: controller?.getCameraInfo(),
              //             builder: (context, snapshot) {
              //               if (snapshot.data != null) {
              //                 return Text(
              //                     'Camera facing ${describeEnum(snapshot.data!)}');
              //               } else {
              //                 return const Text('loading');
              //               }
              //             },
              //           )),
              //     )),
              Positioned(
                  left: (clicked == false)
                      ? MediaQuery.of(context).size.width * 0.33
                      : MediaQuery.of(context).size.width * 0.22,
                  bottom: MediaQuery.of(context).size.width * 0.4,
                  child: Center(child: buildResult()))
            ],
          ),
        ),
      ));

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((clicked == true)
                ? 'Arahkan Camera pada Qr Code '
                : 'Ketuk Untuk Scan'),
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
