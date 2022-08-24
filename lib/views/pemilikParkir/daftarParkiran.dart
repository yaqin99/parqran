import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/component/parkiran.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/model/services.dart';
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
  Color warna = Color.fromRGBO(155, 89, 182, 1);
  QueryResult? result;
  List listParkiran = List.empty(growable: true);

  loadParkiran(int idUser) async {
    const String parkiran = r'''
query loadParkiran($id: Int) {
  Parkirans(id_pengguna: $id) {
    nama
   	koordinat
    alamat
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
        "alamat": item['alamat']
      });
    }
    print(response);
    setState(() {
      // notLoad = true;
    });
  }

  bool notLoad = false;

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
                                        color: Color.fromRGBO(155, 89, 182, 1),
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
                                                  155, 89, 182, 1),
                                            )),
                                        IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(155, 89, 182, 1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
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
                                children: [
                                  const Center(
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
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'Not Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 40,
                                            color: warna),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        : Column(
                            children: listParkiran.map((e) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailParkiran(
                                        nama: e['nama'],
                                        koordinat: e['koordinat'],
                                        alamat: e['alamat']);
                                  }));
                                },
                                child: Parkiran(
                                    lokasi: e["nama"],
                                    areaCode: e['koordinat']),
                              );
                            }).toList(),
                          )
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
                                    backgroundColor:
                                        MaterialStateProperty.all(warna)),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TambahParkiran(
                                        latitude: -0,
                                        longitude: 0,
                                        namaParkiran: '',
                                        alamatParkiran: '',
                                        jamBukaParkiran: '',
                                        jamTutupParkiran: '');
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
        floatingActionButton: ParkirFloatButton(),
        bottomNavigationBar: ParkirBotNav(),
      ),
    );
  }
}
