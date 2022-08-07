import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddKendaraan extends StatefulWidget {
  const AddKendaraan({Key? key}) : super(key: key);

  @override
  State<AddKendaraan> createState() => _AddKendaraanState();
}

class _AddKendaraanState extends State<AddKendaraan> {
  TextEditingController merk = new TextEditingController();
  bool tipeKendaraanMotor = false;
  bool tipeKendaraanMobil = false;
  Color motorText = Color.fromRGBO(52, 152, 219, 1);
  Color mobilText = Color.fromRGBO(52, 152, 219, 1);
  Color? warnaMotorButton;
  Color? warnaMobilButton;
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
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(children: [
              ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Add Kendaraan',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(52, 152, 219, 1)),
                        ),
                      ],
                    )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height * 0.4,
                              // decoration:
                              //     BoxDecoration(border: Border.all(color: Colors.black)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                                child: ListView(
                                  children: [
                                    Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 66),
                                            child: Text(
                                              'Merk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.475,
                                            child: TextField(
                                              controller: merk,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.pink),
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 57),
                                            child: Text(
                                              'Warna',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.475,
                                            child: TextField(
                                              controller: merk,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.pink),
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 72),
                                            child: Text(
                                              'Tipe',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1)),
                                            ),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.black54)),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.475,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.075,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      tipeKendaraanMotor = true;
                                                      tipeKendaraanMobil =
                                                          false;
                                                      motorText =
                                                          Color.fromRGBO(
                                                              52, 152, 219, 1);
                                                      ;
                                                      warnaMotorButton =
                                                          Color.fromRGBO(
                                                              52, 152, 219, 1);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (tipeKendaraanMotor ==
                                                                  true)
                                                              ? warnaMotorButton
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10))),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2348,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.075,
                                                      child: Center(
                                                          child: Text(
                                                        'Motor',
                                                        style: TextStyle(
                                                            color:
                                                                (tipeKendaraanMotor ==
                                                                        true)
                                                                    ? Colors
                                                                        .white
                                                                    : Color
                                                                        .fromRGBO(
                                                                            52,
                                                                            152,
                                                                            219,
                                                                            1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      tipeKendaraanMobil = true;
                                                      tipeKendaraanMotor =
                                                          false;
                                                      mobilText =
                                                          Color.fromRGBO(
                                                              52, 152, 219, 1);
                                                      warnaMobilButton =
                                                          Color.fromRGBO(
                                                              52, 152, 219, 1);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: (tipeKendaraanMobil ==
                                                                  true)
                                                              ? warnaMobilButton
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          10))),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2348,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.075,
                                                      child: Center(
                                                          child: Text(
                                                        'Mobil',
                                                        style: TextStyle(
                                                            color:
                                                                (tipeKendaraanMobil ==
                                                                        true)
                                                                    ? Colors
                                                                        .white
                                                                    : Color
                                                                        .fromRGBO(
                                                                            52,
                                                                            152,
                                                                            219,
                                                                            1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 32),
                                            child: Text(
                                              'No. Polisi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.475,
                                            child: TextField(
                                              controller: merk,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.pink),
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 40),
                                            child: Text(
                                              'No. Stnk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.475,
                                            child: TextField(
                                              controller: merk,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.pink),
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FLoatButton(),
        bottomNavigationBar: BottomNavbar(),
      ),
    );
  }
}
