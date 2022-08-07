import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/landingPage.dart';
import 'package:parqran/views/pengendara/loadingPage.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

class TambahKendaraan extends StatefulWidget {
  const TambahKendaraan({
    Key? key,
  }) : super(key: key);
  @override
  State<TambahKendaraan> createState() => _TambahKendaraanState();
}

class _TambahKendaraanState extends State<TambahKendaraan> {
  bool hold = false;
  Color warna = Colors.transparent;
  TextEditingController merk = new TextEditingController();
  bool tipeKendaraanMotor = false;
  bool tipeKendaraanMobil = false;
  Color motorText = Color.fromRGBO(52, 152, 219, 1);
  Color mobilText = Color.fromRGBO(52, 152, 219, 1);
  Color? warnaMotorButton;
  Color? warnaMobilButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(children: [
            ListView(children: [
              Column(
                children: [
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: Color.fromRGBO(52, 152, 219, 1),
                            ),
                          ),
                        ),
                        Text(
                          'Tambah Motor',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(52, 152, 219, 1)),
                        ),
                      ],
                    )),
                  ),
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4875,
                    height: MediaQuery.of(context).size.height * 0.237,
                    child: Stack(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.477,
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(255, 255, 255, 1)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    side: BorderSide(
                                        color: Color.fromRGBO(52, 152, 219, 1),
                                        width: 3),
                                  )),
                                ),
                                onPressed: () {},
                                child: FaIcon(
                                  FontAwesomeIcons.motorcycle,
                                  size: 100,
                                  color: Color.fromRGBO(52, 152, 219, 1),
                                )),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.146,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(52, 152, 219, 1))),
                              onPressed: () {},
                              child: Icon(Icons.camera_alt_rounded,
                                  color: Colors.white)),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 66),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
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
                                      padding: const EdgeInsets.only(right: 57),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
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
                                      padding: const EdgeInsets.only(right: 72),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.475,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                tipeKendaraanMotor = true;
                                                tipeKendaraanMobil = false;
                                                motorText = Color.fromRGBO(
                                                    52, 152, 219, 1);
                                                ;
                                                warnaMotorButton =
                                                    Color.fromRGBO(
                                                        52, 152, 219, 1);
                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        (tipeKendaraanMotor ==
                                                                true)
                                                            ? warnaMotorButton
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10))),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2348,
                                                height: MediaQuery.of(context)
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
                                                              ? Colors.white
                                                              : Color.fromRGBO(
                                                                  52,
                                                                  152,
                                                                  219,
                                                                  1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                tipeKendaraanMobil = true;
                                                tipeKendaraanMotor = false;
                                                mobilText = Color.fromRGBO(
                                                    52, 152, 219, 1);
                                                warnaMobilButton =
                                                    Color.fromRGBO(
                                                        52, 152, 219, 1);
                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        (tipeKendaraanMobil ==
                                                                true)
                                                            ? warnaMobilButton
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2348,
                                                height: MediaQuery.of(context)
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
                                                              ? Colors.white
                                                              : Color.fromRGBO(
                                                                  52,
                                                                  152,
                                                                  219,
                                                                  1),
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                      padding: const EdgeInsets.only(right: 32),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
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
                                      padding: const EdgeInsets.only(right: 40),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
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
                                      padding: const EdgeInsets.only(right: 17),
                                      child: Text(
                                        'No. Rangka',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
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
                                      padding: const EdgeInsets.only(right: 33),
                                      child: Text(
                                        'Foto Stnk',
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.475,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.469,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.075,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Color
                                                                  .fromRGBO(
                                                                      52,
                                                                      152,
                                                                      219,
                                                                      1))),
                                                  onPressed: () {},
                                                  child: Center(
                                                      child: Row(
                                                    children: [
                                                      Text('Tambah Foto',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                      Icon(
                                                          Icons
                                                              .camera_alt_rounded,
                                                          color: Colors.white)
                                                    ],
                                                  ))),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                width:
                                    MediaQuery.of(context).size.width * 0.950,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.469,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          10))),
                                              backgroundColor: MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      52, 152, 219, 1))),
                                          onPressed: () {},
                                          child: Center(
                                              child: Text('Tambah',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700)))),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FLoatButton(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
