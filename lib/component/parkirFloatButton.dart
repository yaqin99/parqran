import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/scan_masuk.dart';
// import 'package:parqran/views/pengendara/qrScaning.dart';

class ParkirFloatButton extends StatefulWidget {
  const ParkirFloatButton({Key? key}) : super(key: key);

  @override
  State<ParkirFloatButton> createState() => _ParkirFloatButtonState();
}

class _ParkirFloatButtonState extends State<ParkirFloatButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(155, 89, 182, 1),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // return QrGenerate();
          return const ScanMasuk();
        }));
      },
      elevation: 0,
      child: const Icon(
        Icons.qr_code_scanner,
        size: 30,
      ),
    );
  }
}
