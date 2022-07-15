import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Image.asset('assets/parkir.png',
          width: 250,
          height: 250,
          fit: BoxFit.fill,),
        ),
      );
  }
}