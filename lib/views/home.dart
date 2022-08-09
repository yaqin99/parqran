import 'package:flutter/material.dart';
import 'package:parqran/views/pemilikParkir/PemilikParkirMenu.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';

import '../component/logo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are you sure want to Exit?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes')),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button Pressed');

        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.65,
              child: const Logo(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(6),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(52, 152, 219, 1)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return MainMenu();
                    }));
                  },
                  child: const Center(
                      child: Text('Pemilik Kendaraan',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const PemilikParkirMenu();
                      }));
                    },
                    child: const Center(
                        child: Text('Pemilik Parkir',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
