import 'package:flutter/material.dart';

class FLoatButton extends StatefulWidget {
  const FLoatButton({Key? key}) : super(key: key);

  @override
  State<FLoatButton> createState() => _FLoatButtonState();
}

class _FLoatButtonState extends State<FLoatButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.qr_code_scanner,
        size: 30,
      ),
      elevation: 0,
    );
  }
}
