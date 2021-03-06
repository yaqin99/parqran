import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/qrGenerate.dart';
// import 'package:parqran/views/pengendara/qrScaning.dart';

class FLoatButton extends StatefulWidget {
  const FLoatButton({Key? key}) : super(key: key);

  @override
  State<FLoatButton> createState() => _FLoatButtonState();
}

class _FLoatButtonState extends State<FLoatButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(52, 152, 219, 1),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QrGenerate();
        }));
      },
      child: Icon(
        Icons.qr_code_scanner,
        size: 30,
      ),
      elevation: 0,
    );
  }
}
