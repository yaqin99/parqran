import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/component/parkiran.dart';
import 'package:parqran/views/pemilikParkir/detailParkiran.dart';
import 'package:parqran/views/pemilikParkir/tambahParkir.dart';

class Pendapatan extends StatefulWidget {
  const Pendapatan({Key? key}) : super(key: key);

  @override
  State<Pendapatan> createState() => _PendapatanState();
}

class _PendapatanState extends State<Pendapatan> {
  bool hold = false;
  Color warna = Color.fromRGBO(155, 89, 182, 1);
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
                            'Pendapatan',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: warna),
                          ),
                        ],
                      )),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black)),
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: warna,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.125,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Center(
                                  child: Text(
                                    'HARI',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/motorParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '20',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/carParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '110',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black)),
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: warna,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.125,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Center(
                                  child: Text(
                                    'MINGGU',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/motorParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '200',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/carParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '400',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black)),
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: warna,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.125,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Center(
                                  child: Text(
                                    'BULAN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/motorParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '3245',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/carParkir.png',
                                        width: 75,
                                        height: 75,
                                      ),
                                      Text(
                                        '980',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: warna,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ])
                ],
              ),
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ParkirFloatButton(),
        bottomNavigationBar: ParkirBotNav(),
      ),
    );
  }
}
