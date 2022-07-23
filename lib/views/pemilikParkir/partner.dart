import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/daftarKendaraanPinjam.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';

class Partner extends StatefulWidget {
  const Partner({Key? key}) : super(key: key);

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  bool show = false;
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
                          Text(
                            'Tambah Partner',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(155, 89, 182, 1)),
                          ),
                        ],
                      )),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          height: MediaQuery.of(context).size.height * 0.1524,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(color: Colors.black),
                                    // ),
                                    width: MediaQuery.of(context).size.width *
                                        0.668,
                                    height: MediaQuery.of(context).size.height *
                                        0.085,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Masukan ID Pengendara',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 25, horizontal: 25),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromRGBO(
                                                        155, 89, 182, 1))),
                                        onPressed: () {
                                          setState(() {
                                            show = true;
                                            print(show);
                                          });
                                        },
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    (show == true)
                        ? Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hasil Cari',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(155, 89, 182, 1)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      side: BorderSide(
                                                          color: Color.fromRGBO(
                                                              155, 89, 182, 1),
                                                          width: 3),
                                                    )),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                                onPressed: () {},
                                                child: Center(
                                                    child: Icon(
                                                  Icons.person,
                                                  color: Color.fromRGBO(
                                                      155, 89, 182, 1),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          155, 89, 182, 1)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 11, bottom: 11),
                                                  child: Text(
                                                    'Jl. Sersan Mesrul Gg. 3B',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Color.fromRGBO(
                                                            155, 89, 182, 1)),
                                                  ),
                                                ),
                                                Text(
                                                  '085232324069',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          155, 89, 182, 1)),
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
                            ],
                          )
                        : Container()
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
