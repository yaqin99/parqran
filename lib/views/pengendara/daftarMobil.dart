import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/emptyMotor.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:parqran/component/mobil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/views/pengendara/detailMobil.dart';
import 'package:parqran/views/pengendara/tambahKendaraan.dart';
import 'package:provider/provider.dart';

import '../../component/emptyMobil.dart';
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

  loadMobil(int idUser) async {
    const String mobil = r'''
query loadKendaraan($id: Int) {
  Kendaraans(id: $id) {
    nama
    merk
    no_registrasi
    no_stnk
    jenis
    warna
    id_kendaraan
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(
        document: gql(mobil), variables: <String, dynamic>{"id": idUser});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    for (var item in response) {
      listMobil.add({
        "nama": item['nama'],
        "merk": item['merk'],
        "no_registrasi": item['no_registrasi'],
        "no_stnk": item['no_stnk'],
        "jenis": item['jenis'],
        "warna": item['warna'],
        "id_kendaraan": item['id_kendaraan']
      });

      listMobil.removeWhere((item) => item['jenis'] == '0');
    }
    print(listMobil);
    setState(() {});
  }

  getMobil() async {
    final String id_pengguna = await Provider.of<Person>(context, listen: false)
        .getIdPengguna
        .toString();
    int vehicleId = int.parse(id_pengguna);
    if (vehicleId != null) {
      loadMobil(vehicleId);
    }
  }

  @override
  void initState() {
    getMobil();
    super.initState();
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
                                          onPressed: () {},
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
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 18),
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       Navigator.pop(
                                    //         context,
                                    //       );
                                    //     },
                                    //     child: Icon(
                                    //       Icons.arrow_back,
                                    //       size: 35,
                                    //       color: Color.fromRGBO(52, 152, 219, 1),
                                    //     ),
                                    //   ),
                                    // ),
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    'Not Found',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 40,
                                        color: Color.fromRGBO(52, 152, 219, 1)),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: listMobil.map((e) {
                            return GestureDetector(
                                onLongPress: () {
                                  hold = true;
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
                                        no_rangka: 'Masih gak Ada');
                                  }));
                                },
                                child: Mobil(
                                    nama: e['nama'],
                                    noPol: e['no_registrasi'],
                                    noStnk: e['no_stnk']));
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TambahKendaraan(
                                      isMobil: true,
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
