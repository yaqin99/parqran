import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:provider/provider.dart';

class HistoryParkir extends StatefulWidget {
  const HistoryParkir({Key? key}) : super(key: key);

  @override
  State<HistoryParkir> createState() => _HistoryParkirState();
}

class _HistoryParkirState extends State<HistoryParkir> {
  String? id_pengguna;
  List historys = List.empty(growable: true);
  QueryResult? result;

  Future<bool?> backToMenu(BuildContext context) async {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return const MainMenu();
    }));
  }

  getHistory() async {
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    var data = await Services.getHistory(int.parse(idPengguna));
    for (var a in data) {
      historys.add({
        "lokasi": a['nama'],
        "masuk": a['jam_masuk'],
        "keluar": a['jam_keluar'],
        "tanggal": a['tanggal'],
      });
    }
    print(historys);
    setState(() {
      notLoad = true;
    });
  }

  bool notLoad = false;

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button Pressed');

        final shouldPop = await backToMenu(context);
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'History Parkir',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: historys.map((e) {
                        return History(
                            lokasi: e['lokasi'],
                            masuk: e['masuk'],
                            tanggal: e['tanggal'],
                            keluar: e['keluar']);
                      }).toList(),
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
      ),
    );
  }
}
