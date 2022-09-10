import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatefulWidget {
  final int idPengguna;
  final int idKendaraan;
  const QrGenerate(
      {Key? key, required this.idPengguna, required this.idKendaraan})
      : super(key: key);

  @override
  State<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: QrImage(
            data: widget.idKendaraan.toString(),
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
