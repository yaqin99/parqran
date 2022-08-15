import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/history.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/model/services.dart';
import 'package:provider/provider.dart';

import '../../model/person.dart';

class HistoryParkir extends StatefulWidget {
  const HistoryParkir({Key? key}) : super(key: key);

  @override
  State<HistoryParkir> createState() => _HistoryParkirState();
}

class _HistoryParkirState extends State<HistoryParkir> {
  String? id_pengguna;
  List listMotor = List.empty(growable: true);
  QueryResult? result;
  var data;

  loadMotor(int idUser) async {
    const String motor = r'''
query loadKendaraan($id: Int, $jenis: Int) {
  Kendaraans(id: $id, jenis: $jenis) {
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
        document: gql(motor), variables: <String, dynamic>{"id": idUser});
    result = await Services.gqlQuery(queryOptions);
    var response = result!.data!['Kendaraans'];
    for (var item in response) {
      listMotor.add({
        "nama": item['nama'],
        "merk": item['merk'],
        "no_registrasi": item['no_registrasi'],
        "no_stnk": item['no_stnk'],
        "jenis": item['jenis'],
        "warna": item['warna'],
        "id_kendaraan": item['id_kendaraan']
      });
    }
    print(listMotor);
    setState(() {});
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
      ),
    );
  }
}
