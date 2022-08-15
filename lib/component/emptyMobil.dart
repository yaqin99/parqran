import 'package:flutter/material.dart';

class EmptyMobil extends StatelessWidget {
  const EmptyMobil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/mobilNotFound.png',
          width: 200,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
