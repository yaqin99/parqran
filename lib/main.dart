
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:parqran/views/landingPage.dart';
import 'package:provider/provider.dart';

import 'model/person.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  if (Platform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => Person(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LandingPage(
          isLogOut: true,
        ),
      ),
    );
  }
}
