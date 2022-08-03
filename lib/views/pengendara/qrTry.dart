import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCoba extends StatefulWidget {
  const QrCoba({Key? key}) : super(key: key);

  @override
  State<QrCoba> createState() => _QrCobaState();
}

class _QrCobaState extends State<QrCoba> {
  GlobalKey _qrKey = GlobalKey();
  var _result;
  QRViewController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller?.resumeCamera();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(
                cutOutSize: MediaQuery.of(context).size.width * 0.8),
            onQRViewCreated: (QRViewController controller) {
              this._controller = controller;
            }),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 60),
            child: Text(
              'Scanner',
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_off,
                  )),
              IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_off,
                  )),
              IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_off,
                  )),
            ],
          ),
        )
      ],
    ));
  }
}
