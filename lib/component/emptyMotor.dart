import 'package:flutter/material.dart';

class EmptyMotor extends StatelessWidget {
  const EmptyMotor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/motorNotFound.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
