import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/emptyMotor.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pengendara/detailMotor.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:parqran/views/pengendara/tambahKendaraan.dart';
import 'package:provider/provider.dart';

import '../../model/kendaraan.dart';
import '../../model/person.dart';

class DaftarMotor extends StatefulWidget {
  const DaftarMotor({Key? key}) : super(key: key);

  @override
  State<DaftarMotor> createState() => _DaftarMotorState();
}

class _DaftarMotorState extends State<DaftarMotor> {
  String? selected;
  bool hold = false;
  Color warna = Colors.transparent;
  Color backColor = Colors.black;
  String? id_pengguna;
  List listMotor = List.empty(growable: true);
  QueryResult? result;
  late AnimationController controller;
  String? namaEdit;
  String? merkEdit;
  String? warnaEdit;
  String? noPolEdit;
  String? noStnkEdit;
  String? noRangkaEdit;
  String? fotoEdit;
  String? idKendaraan;

  loadMotor(int idUser) async {
    const String motor = r'''
query loadKendaraan($id_pengguna: Int, $jenis: Int) {
  Kendaraans(id_pengguna: $id_pengguna, jenis: $jenis) {
    nama
    merk
    no_registrasi
    no_stnk
    no_rangka
    jenis
    warna
    id_kendaraan
    foto_kendaraan
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(
        document: gql(motor),
        variables: <String, dynamic>{"id_pengguna": idUser, "jenis": 0});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    for (var item in response) {
      listMotor.add({
        "nama": item['nama'],
        "merk": item['merk'],
        "no_registrasi": item['no_registrasi'],
        "no_stnk": item['no_stnk'],
        "no_rangka": item['no_rangka'],
        "jenis": item['jenis'],
        "warna": item['warna'],
        "id_kendaraan": item['id_kendaraan'],
        "foto_kendaraan": item['foto_kendaraan']
      });
    }
    print(response);
    setState(() {
      notLoad = true;
    });
  }

  getMotor() async {
    final String id_pengguna = await Provider.of<Person>(context, listen: false)
        .getIdPengguna
        .toString();
    int vehicleId = int.parse(id_pengguna);
    if (vehicleId != null) {
      loadMotor(vehicleId);
    }
  }

  bool notLoad = false;

  @override
  void initState() {
    getMotor();

    super.initState();
  }

  Future<bool?> backToMenu(BuildContext context) async {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return MainMenu();
    }));
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
                      child: Container(
                          child: (hold == true)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hold = false;
                                          warna = Colors.transparent;
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.xmark,
                                        size: 26,
                                        color: Color.fromRGBO(52, 152, 219, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons
                                                  .photo_size_select_actual_rounded,
                                              size: 26,
                                              color: Color.fromRGBO(
                                                  52, 152, 219, 1),
                                            )),
                                        IconButton(
                                          onPressed: () {
                                            hold = false;
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return TambahKendaraan(
                                                isMobil: false,
                                                isEdit: true,
                                                namaEdit: namaEdit!,
                                                merkEdit: merkEdit!,
                                                warnaEdit: warnaEdit!,
                                                noPolEdit: noPolEdit!,
                                                noStnkEdit: noStnkEdit!,
                                                noRangkaEdit: noRangkaEdit!,
                                                idKendaraan:
                                                    idKendaraan!.toString(),
                                              );
                                            }));
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
                                            FontAwesomeIcons.trash,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Daftar Motor',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1)),
                                    ),
                                  ],
                                )),
                    ),
                    (listMotor.isEmpty)
                        ? !notLoad
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                  ),
                                  const Center(
                                      child: CircularProgressIndicator(
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1)))
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'Not Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 40,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        : Column(
                            children: listMotor.map((e) {
                            return GestureDetector(
                              onLongPress: () {
                                hold = true;
                                namaEdit = e['nama'];
                                merkEdit = e['merk'];
                                warnaEdit = e['warna'];
                                noPolEdit = e['no_registrasi'];
                                noStnkEdit = e['no_stnk'];
                                noRangkaEdit = e['no_rangka'];
                                idKendaraan = e['id_kendaraan'].toString();
                                setState(() {});
                              },
                              onTap: () {
                                hold = false;
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailMotor(
                                    nama: e['nama'],
                                    merk: e['merk'],
                                    warna: e['warna'],
                                    no_registrasi: e['no_registrasi'],
                                    no_stnk: e['no_stnk'],
                                    no_rangka: 'Masih gak Ada',
                                    foto_kendaraan: e['foto_kendaraan'],
                                  );
                                }));
                              },
                              child: Motor(
                                nama: e['nama'],
                                noPol: e['no_registrasi'],
                                warna: e['no_stnk'],
                              ),
                            );
                          }).toList())
                  ])
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(7),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(52, 152, 219, 1))),
                                onPressed: () {
                                  hold = false;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TambahKendaraan(
                                      isMobil: false,
                                      isEdit: false,
                                      namaEdit: '',
                                      merkEdit: '',
                                      warnaEdit: '',
                                      noPolEdit: '',
                                      noStnkEdit: '',
                                      noRangkaEdit: '',
                                      idKendaraan: '',
                                    );
                                  }));
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
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
