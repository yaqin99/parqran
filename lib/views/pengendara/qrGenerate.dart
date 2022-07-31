import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatelessWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: QrImage(
            data: '123',
            version: 6,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            size: 300,
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
