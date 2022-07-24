import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/views/pemilikParkir/daftarParkiran.dart';
import 'package:parqran/views/pemilikParkir/managementParkir.dart';
import 'package:parqran/views/pemilikParkir/partner.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/pinjamKendaraan.dart';

class PemilikParkirMenu extends StatefulWidget {
  const PemilikParkirMenu({Key? key}) : super(key: key);

  @override
  State<PemilikParkirMenu> createState() => _PemilikParkirMenuState();
}

class _PemilikParkirMenuState extends State<PemilikParkirMenu> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Are you sure want to Exit?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('No')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes')),
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
          body: Center(
            child: Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(155, 89, 182, 1))),
                                onPressed: () {},
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          CircleBorder()),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromRGBO(155, 89, 182, 1))),
                                  onPressed: () {},
                                  child: Center(
                                      child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 30,
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.41,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DaftarParkiran();
                                    }));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromRGBO(
                                                    239, 201, 255, 1)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.135,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.295,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7, left: 20),
                                                  child: Text(
                                                    '12',
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            155, 89, 182, 1)),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/map2.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Daftar Parkiran'))
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DaftarMobil();
                                    }));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromRGBO(
                                                    239, 201, 255, 1)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.135,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.295,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7, left: 20),
                                                  child: Text(
                                                    '3',
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            155, 89, 182, 1)),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/monetary.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Pendapatan'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ManageParkir();
                                    }));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromRGBO(
                                                    239, 201, 255, 1)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.135,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.295,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7, left: 20),
                                                  child: Text(
                                                    '114',
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            155, 89, 182, 1)),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/carParking.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Jumlah Parkir'))
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Partner();
                                    }));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromRGBO(
                                                    239, 201, 255, 1)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.135,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.295,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7, left: 20),
                                                  child: Text(
                                                    '1',
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            155, 89, 182, 1)),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/partner.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Partnership'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ParkirFloatButton(),
          bottomNavigationBar: ParkirBotNav()),
    );
  }
}
