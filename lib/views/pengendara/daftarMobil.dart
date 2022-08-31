import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/emptyMotor.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:parqran/component/mobil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'package:parqran/views/pengendara/detailMobil.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:parqran/views/pengendara/tambahKendaraan.dart';
import 'package:provider/provider.dart';

import '../../component/emptyMobil.dart';
import '../../model/kendaraan.dart';
import '../../model/services.dart';

class DaftarMobil extends StatefulWidget {
  const DaftarMobil({Key? key}) : super(key: key);

  @override
  State<DaftarMobil> createState() => _DaftarMobilState();
}

class _DaftarMobilState extends State<DaftarMobil> {
  bool hold = false;
  Color warna = Colors.transparent;
  List listMobil = List.empty(growable: true);
  QueryResult? result;
  String? namaEdit;
  String? merkEdit;
  String? warnaEdit;
  String? noPolEdit;
  String? noStnkEdit;
  String? noRangkaEdit;
  String? fotoEdit;
  int? idKendaraan;
  String? fotoKendaraan;
  String fotoStnk = '';

  _deleteKendaraan(int id) async {
    try {
      var response = await Services.deleteKendaraan(id);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DaftarMobil();
      }));
    } catch (e) {
      print(e);
    }
  }

  loadMobil(int idUser) async {
    const String mobil = r'''
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
    foto_stnk
	}
}
''';
    final QueryOptions queryOptions = QueryOptions(
        document: gql(mobil),
        variables: <String, dynamic>{"id_pengguna": idUser, "jenis": 1});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    for (var item in response) {
      listMobil.add({
        "nama": item['nama'],
        "merk": item['merk'],
        "no_registrasi": item['no_registrasi'],
        "no_stnk": item['no_stnk'],
        "no_rangka": item['no_rangka'],
        "jenis": item['jenis'],
        "warna": item['warna'],
        "id_kendaraan": item['id_kendaraan'],
        "foto_kendaraan": item['foto_kendaraan'],
        "foto_stnk": item['foto_stnk'],
      });
    }
    print(listMobil);
    setState(() {
      notLoad = true;
    });
  }

  bool notLoad = false;

  getMobil() {
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    int vehicleId = int.parse(idPengguna);
    if (vehicleId != null) {
      loadMobil(vehicleId);
    }
  }

  @override
  void initState() {
    getMobil();
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
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: const Icon(
                                        //       Icons
                                        //           .photo_size_select_actual_rounded,
                                        //       size: 26,
                                        //       color: Color.fromRGBO(
                                        //           52, 152, 219, 1),
                                        //     )),
                                        IconButton(
                                          onPressed: () {
                                            hold = false;
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return TambahKendaraan(
                                                isMobil: true,
                                                isEdit: true,
                                                namaEdit: namaEdit!,
                                                merkEdit: merkEdit!,
                                                warnaEdit: warnaEdit!,
                                                noPolEdit: noPolEdit!,
                                                noStnkEdit: noStnkEdit!,
                                                noRangkaEdit: noRangkaEdit!,
                                                idKendaraan: idKendaraan!,
                                                fotoKendaraanEdit:
                                                    fotoKendaraan!,
                                                fotoStnkEdit: fotoStnk,
                                              );
                                            }));
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _deleteKendaraan(idKendaraan!);
                                          },
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
                                  children: const [
                                    Text(
                                      'Daftar Mobil',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1)),
                                    ),
                                  ],
                                )),
                    ),
                    (listMobil.isEmpty)
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
                                  const Center(
                                    child: Text(
                                      'Not Found',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 40,
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1)),
                                    ),
                                  )
                                ],
                              )
                        : Column(
                            children: listMobil.map((e) {
                            return GestureDetector(
                                onLongPress: () {
                                  hold = true;
                                  namaEdit = e['nama'];
                                  merkEdit = e['merk'];
                                  warnaEdit = e['warna'];
                                  noPolEdit = e['no_registrasi'];
                                  noStnkEdit = e['no_stnk'];
                                  noRangkaEdit = e['no_rangka'];
                                  idKendaraan = e['id_kendaraan'];
                                  fotoKendaraan = e['foto_kendaraan'];
                                  fotoStnk = e['foto_stnk'];
                                  setState(() {});
                                },
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailMobil(
                                      nama: e['nama'],
                                      merk: e['merk'],
                                      warna: e['warna'],
                                      no_registrasi: e['no_registrasi'],
                                      no_stnk: e['no_stnk'],
                                      no_rangka: e['no_rangka'],
                                      foto: e['foto_kendaraan'],
                                    );
                                  }));
                                },
                                child: Mobil(
                                  nama: e['nama'],
                                  noPol: e['no_registrasi'],
                                  noStnk: e['no_stnk'],
                                  foto: e['foto_kendaraan'],
                                ));
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
                                    return const TambahKendaraan(
                                      isMobil: true,
                                      isEdit: false,
                                      namaEdit: '',
                                      merkEdit: '',
                                      warnaEdit: '',
                                      noPolEdit: '',
                                      noStnkEdit: '',
                                      noRangkaEdit: '',
                                      idKendaraan: 0,
                                      fotoKendaraanEdit: '',
                                      fotoStnkEdit: '',
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
