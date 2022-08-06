import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/daftarKendaraanPinjam.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmPinjam extends StatefulWidget {
  const ConfirmPinjam({Key? key}) : super(key: key);

  @override
  State<ConfirmPinjam> createState() => _ConfirmPinjamState();
}

class _ConfirmPinjamState extends State<ConfirmPinjam> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(children: [
            ListView(
              children: [
                Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [],
                    )),
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1),
                                                  width: 3),
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () {},
                                        child: Center(
                                            child: Icon(
                                          Icons.person,
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1),
                                          size: 40,
                                        ))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Moh Ainul Yaqin',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  52, 152, 219, 1)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 11, bottom: 11),
                                          child: Text(
                                            'Jl. Sersan Mesrul Gg. 3B',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    52, 152, 219, 1)),
                                          ),
                                        ),
                                        Text(
                                          '085232324069',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  52, 152, 219, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DaftarKendaraan(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Center(
                          child: Text(
                            'Apakah anda mengizinkan Andri untuk meminjam kendaraan anda ?',
                            maxLines: 3,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    side: BorderSide(
                                                        color: Colors.red))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red[600])),
                                        onPressed: () {},
                                        child: FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Tolak',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green[600])),
                                        onPressed: () {},
                                        child: FaIcon(
                                          FontAwesomeIcons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Terima',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  )
                ])
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
