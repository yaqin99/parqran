import 'package:flutter/material.dart';
import 'package:parqran/component/logo.dart';
import 'package:parqran/views/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Logo(),
          ),
          Text(
            'Loading ...',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromRGBO(52, 152, 219, 1)),
          )
        ],
      ),
    );
  }
}
