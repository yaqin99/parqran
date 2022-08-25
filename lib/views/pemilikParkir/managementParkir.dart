import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/daftarKendaraanPinjam.dart';
import 'package:parqran/component/daftarParkir.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/component/parkirLocation.dart';
import 'package:parqran/model/person.dart';
import 'package:provider/provider.dart';

import '../../model/services.dart';

class ManageParkir extends StatefulWidget {
  const ManageParkir({Key? key}) : super(key: key);

  @override
  State<ManageParkir> createState() => _ManageParkirState();
}

class _ManageParkirState extends State<ManageParkir> {
  bool clicked = false;
  Color warnaButton = Colors.white;
  bool warnaPress = false;
  Color warnaText = Color.fromRGBO(155, 89, 182, 1);
  bool show = false;
  QueryResult? result;
  List listParkiran = List.empty(growable: true);
  String? namaParkiran;
  String? lokasi;
  loadParkiran(int idUser) async {
    const String parkiran = r'''
query loadParkiran($id: Int) {
  Parkirans(id_pengguna: $id) {
    nama
   	koordinat
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(
        document: gql(parkiran), variables: <String, dynamic>{"id": idUser});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Parkirans'];
    for (var item in response) {
      listParkiran.add({
        "nama": item['nama'],
        "koordinat": item['koordinat'],
      });
    }
    print(response);
    setState(() {
      // notLoad = true;
    });
  }

  getParkiran() async {
    final String id_pengguna = await Provider.of<Person>(context, listen: false)
        .getIdPengguna
        .toString();
    int idDriver = int.parse(id_pengguna);
    if (idDriver != null) {
      loadParkiran(idDriver);
    }
  }

  @override
  void initState() {
    super.initState();
    getParkiran();
  }

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
    bool notLoad = false;
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
                            'Management Parkir',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(155, 89, 182, 1)),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: Color.fromRGBO(155, 89, 182, 1))),
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        (listParkiran.isEmpty)
                            ? Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.876,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Tidak ada Parkiran',
                                        style: TextStyle(
                                            color: warnaText,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Row(
                                children: listParkiran.map((e) {
                                  var index = listParkiran.indexOf(e) + 1;
                                  return GestureDetector(
                                      onTap: () {
                                        namaParkiran = e['nama'];
                                        lokasi = e['koordinat'];
                                        setState(() {});
                                      },
                                      child: ParkirSwipeButton(
                                          nomer: index.toString()));
                                }).toList(),
                              ),
                      ]),
                    ),
                    (namaParkiran != null)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Parkiran',
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
                                                  shape:
                                                      MaterialStateProperty.all(
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
                                                      MaterialStateProperty.all(
                                                          Colors.white)),
                                              onPressed: () {},
                                              child: Center(
                                                  child: Image.asset(
                                                'assets/map2.png',
                                                width: 50,
                                                height: 50,
                                              ))),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                namaParkiran!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    color: Color.fromRGBO(
                                                        155, 89, 182, 1)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 11, bottom: 11),
                                                child: Text(
                                                  lokasi!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          155, 89, 182, 1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Daftar Kendaraan',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                155, 89, 182, 1)),
                                      ),
                                      DaftarParkir(),
                                      DaftarParkir(),
                                      DaftarParkir(),
                                      DaftarParkir(),
                                      DaftarParkir(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
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
