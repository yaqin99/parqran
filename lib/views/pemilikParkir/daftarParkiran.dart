import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/component/parkiran.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pemilikParkir/PemilikParkirMenu.dart';
import 'package:parqran/views/pemilikParkir/detailParkiran.dart';
import 'package:parqran/views/pemilikParkir/tambahParkir.dart';
import 'package:provider/provider.dart';

class DaftarParkiran extends StatefulWidget {
  const DaftarParkiran({Key? key}) : super(key: key);

  @override
  State<DaftarParkiran> createState() => _DaftarParkiranState();
}

class _DaftarParkiranState extends State<DaftarParkiran> {
  bool hold = false;
  Color warna = const Color.fromRGBO(155, 89, 182, 1);
  QueryResult? result;
  List listParkiran = List.empty(growable: true);
  String? nama;
  String? koordinat;
  String? alamat;
  String? foto;
  String? fotoEdit;
  String? buka;
  String? tutup;
  int? idParkiran;
  int? idPengguna;

  loadParkiran(int idUser) async {
    const String parkiran = r'''
query loadParkiran($id: Int) {
  Parkirans(id_pengguna: $id) {
    id_parkiran
    nama
   	koordinat
    alamat
    foto
    jam_buka
    jam_tutup
	}
}
''';

    final QueryOptions queryOptions = QueryOptions(
        document: gql(parkiran), variables: <String, dynamic>{"id": idUser});
    result = await Services.gqlQuery(queryOptions);
    print('msg: $result');
    var response = result!.data!['Parkirans'];
    for (var item in response) {
      listParkiran.add({
        "id_parkiran": item['id_parkiran'],
        "nama": item['nama'],
        "koordinat": item['koordinat'],
        "alamat": item['alamat'],
        "foto": item['foto'],
        "jam_buka": item['jam_buka'],
        "jam_tutup": item['jam_tutup'],
      });
    }
    print('msg: $listParkiran');
    setState(() {
      notLoad = true;
    });
  }

  bool notLoad = false;
  int? idDriver;
  getParkiran() async {
    final String id_pengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    idDriver = int.parse(id_pengguna);
    loadParkiran(idDriver!);
  }

  @override
  void initState() {
    super.initState();
    getParkiran();
  }

  _deleteParkiran(int id) async {
    try {
      await Services.deleteParkiran(id);
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const DaftarParkiran();
        }));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> backToMenu(BuildContext context) async {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return const PemilikParkirMenu();
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
          child: SizedBox(
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(children: [
              ListView(
                children: [
                  Column(children: [
                    SizedBox(
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
                                        });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.xmark,
                                        size: 26,
                                        color: Color.fromRGBO(155, 89, 182, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return TambahParkiran(
                                                isEdit: true,
                                                koordinat: koordinat!,
                                                namaParkiran: nama!,
                                                alamatParkiran: alamat!,
                                                jamBukaParkiran: buka!,
                                                jamTutupParkiran: tutup!,
                                                foto: fotoEdit!,
                                                idParkiranEdit: idParkiran!,
                                              );
                                            }));
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(155, 89, 182, 1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _deleteParkiran(idParkiran!);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.trash,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(155, 89, 182, 1),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Daftar Parkiran',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: warna,
                                        )),
                                  ],
                                )),
                    ),
                    (listParkiran.isEmpty)
                        ? !notLoad
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Center(
                                      child: CircularProgressIndicator(
                                          color:
                                              Color.fromRGBO(155, 89, 182, 1)))
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                  ),
                                  Center(
                                    child: Text(
                                      'Not Found',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 40,
                                          color: warna),
                                    ),
                                  )
                                ],
                              )
                        : Column(
                            children: listParkiran.map((e) {
                              return GestureDetector(
                                onLongPress: () {
                                  hold = true;
                                  idParkiran = e['id_parkiran'];
                                  nama = e['nama'];
                                  koordinat = e['koordinat'];
                                  alamat = e['alamat'];
                                  foto = e['foto'];
                                  buka = e['jam_buka'];
                                  tutup = e['jam_tutup'];
                                  fotoEdit = e['foto'];
                                  print(idParkiran);
                                  setState(() {});
                                },
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailParkiran(
                                      id: e['id_parkiran'],
                                      nama: e['nama'],
                                      koordinat: e['koordinat'],
                                      alamat: e['alamat'],
                                      foto: e['foto'],
                                    );
                                  }));
                                },
                                child: Parkiran(
                                    lokasi: e["nama"],
                                    areaCode: e['koordinat'], foto: '${dotenv.env['API']}${e['foto'].replaceFirst(RegExp(r'^public'), '')}',)
                              );
                            }).toList(),
                          )
                  ])
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
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
                                    backgroundColor:
                                        MaterialStateProperty.all(warna)),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const TambahParkiran(
                                      koordinat: '0',
                                      isEdit: false,
                                      namaParkiran: '',
                                      alamatParkiran: '',
                                      jamBukaParkiran: '',
                                      jamTutupParkiran: '',
                                      foto: '',
                                      idParkiranEdit: 0,
                                    );
                                  }));
                                },
                                child: const Icon(
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
        floatingActionButton: const ParkirFloatButton(),
        bottomNavigationBar: const ParkirBotNav(),
      ),
    );
  }
}
