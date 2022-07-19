import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HistoryParkir extends StatefulWidget {
  const HistoryParkir({Key? key}) : super(key: key);

  @override
  State<HistoryParkir> createState() => _HistoryParkirState();
}

class _HistoryParkirState extends State<HistoryParkir> {
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
                          'History Parkir',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(52, 152, 219, 1)),
                        ),
                      ],
                    )),
                  ),
                  Column(
                    children: [
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
                      ),
                      History(
                        lokasi: 'Pamekasan Plaza',
                        masuk: '14.00',
                        tanggal: '23 Agustus 2022',
                        keluar: '15.15',
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
      floatingActionButton: FLoatButton(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
