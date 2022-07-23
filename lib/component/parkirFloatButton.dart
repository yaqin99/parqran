import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/qrGenerate.dart';
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
      backgroundColor: Color.fromRGBO(155, 89, 182, 1),
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
