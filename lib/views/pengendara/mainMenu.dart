import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/model/repository.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'dart:convert' as convert;
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/pinjamKendaraan.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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

  Person? person;
  getData() async {
    Person? result = await Services.getById();
    if (result != null) {
      setState(() {
        person = result;
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (person != null)
                              ? PersonCard(person: person!)
                              : const Text(
                                  'Loading ...',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(52, 152, 219, 1)),
                                ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(52, 152, 219, 1))),
                                onPressed: () {},
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ))),
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
                                      return DaftarMotor();
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
                                                    217, 240, 255, 1)),
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
                                                            52, 152, 219, 1)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Image.asset(
                                                  'assets/motorcyclenew.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Daftar Motor'))
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
                                                    217, 240, 255, 1)),
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
                                                            52, 152, 219, 1)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Image.asset(
                                                  'assets/carnew.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Daftar Mobil'))
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
                                      return HistoryParkir();
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
                                                    217, 240, 255, 1)),
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
                                                            52, 152, 219, 1)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Image.asset(
                                                  'assets/list.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('History Parkir'))
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PinjamKendaraan();
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
                                                    217, 240, 255, 1)),
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
                                                            52, 152, 219, 1)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Image.asset(
                                                  'assets/pinjam.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Pinjam Kendaraan'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  // RaisedButton(
                  //   onPressed: () async {
                  //     Person? result = await Services.getById();
                  //     if (result != null) {
                  //       setState(() {
                  //         person = result;
                  //       });
                  //     }
                  //   },
                  //   child: Text('Klik'),
                  // )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FLoatButton(),
          bottomNavigationBar: BottomNavbar()),
    );
  }
}
