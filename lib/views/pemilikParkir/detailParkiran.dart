import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/landingPage.dart';
import 'package:parqran/views/pemilikParkir/pendapatan.dart';
import 'package:parqran/views/pengendara/loadingPage.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

import '../pengendara/qrGenerate.dart';

class DetailParkiran extends StatefulWidget {
  final String nama;
  final String koordinat;
  final String alamat;
  const DetailParkiran({
    Key? key,
    required this.nama,
    required this.koordinat,
    required this.alamat,
  }) : super(key: key);
  @override
  State<DetailParkiran> createState() => _DetailParkiranState();
}

class _DetailParkiranState extends State<DetailParkiran> {
  bool hold = false;
  Color warna = Color.fromRGBO(155, 89, 182, 1);

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
          child: Column(children: [
            Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 1,
              child: Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
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
                          color: warna,
                        ),
                      ),
                    ),
                    Text(
                      'Detail Parkiran',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: warna),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.433,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all(warna)),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Pendapatan();
                                  }));
                                },
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.circleDollarToSlot,
                                    size: 28,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      width: MediaQuery.of(context).size.width * 0.477,
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'http://gbparking.co.id/wp-content/uploads/2019/01/whatsapp-image-2018-04-12-at-165511-6663f53084225c5dffae1181f0807e16_600x400-600x380.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
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
                            backgroundColor: MaterialStateProperty.all(warna)),
                        onPressed: () {},
                        child: Icon(Icons.camera_alt_rounded,
                            color: Colors.white)),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 79),
                                child: Text(
                                  'Nama',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: warna),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.nama,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: warna),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 66),
                                child: Text(
                                  'Alamat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: warna),
                                ),
                              ),
                              Text(
                                widget.alamat,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                    color: warna),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 44),
                                child: Text(
                                  'Koordinat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: warna),
                                ),
                              ),
                              Text(
                                widget.koordinat,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                    color: warna),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QrGenerate();
                          }));
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.21,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(217, 240, 255, 1)),
                              ),
                            ),
                            Image.asset('assets/qrCode.png',
                                width: 200, height: 200),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Generate Qr Code'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.21,
                              height: MediaQuery.of(context).size.height * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(217, 240, 255, 1)),
                            ),
                          ),
                          Image.asset('assets/download.png',
                              width: 200, height: 200),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text('Download Qr Code'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ParkirFloatButton(),
      bottomNavigationBar: ParkirBotNav(),
    );
  }
}
