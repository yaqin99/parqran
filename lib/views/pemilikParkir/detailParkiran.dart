import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/mqtt_wrapper.dart';
import 'package:parqran/views/pemilikParkir/pendapatan.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pengendara/qrGenerate.dart';

class DetailParkiran extends StatefulWidget {
  final String nama;
  final String koordinat;
  final String alamat;
  final String foto;
  final int id;
  const DetailParkiran({
    Key? key,
    required this.nama,
    required this.koordinat,
    required this.alamat,
    required this.foto,
    required this.id,
  }) : super(key: key);
  @override
  State<DetailParkiran> createState() => _DetailParkiranState();
}

class _DetailParkiranState extends State<DetailParkiran> {
  bool hold = false;
  Color warna = const Color.fromRGBO(155, 89, 182, 1);
  String message = '';
  late MQTTClientWrapper clientWrapper;

  Future<void> _saveDiterima(data) async {
    try {
      var resp = await Dio().post('${dotenv.env['API']!}/parking/here', data: {
        'id_parkiran': data['idParkir'],
        'id_pengguna': data['idPengguna'],
        'id_kendaraan': data['idKendaraan']
      });
      // anggep tersimpan
      if (kDebugMode) {
        print('msg: ${resp.data}');
      }
      clientWrapper.publishMessage('parkir/${widget.id}',
          jsonEncode({'idPengguna': data['idPengguna'], 'status': 'diterima'}));
    } catch (e) {
      if (kDebugMode) {
        print('msg: error: $e');
      }
    }
  }

  void _setDitolak(data) {
    clientWrapper.publishMessage('parkir/${widget.id}',
        jsonEncode({'idPengguna': data['idPengguna'], 'status': 'ditolak'}));
  }

  @override
  void initState() {
    clientWrapper = MQTTClientWrapper();
    clientWrapper.prepareMtqqtClient('parkir/${widget.id}');
    clientWrapper.onMessageReceived = (String msg) {
      if (kDebugMode) {
        print('msg: $msg');
      }
      final data = jsonDecode(msg);
      setState(() {
        message = msg;
      });
      if (data['status'] == 'waiting') {
        // tampilkan dialog
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Pemberitahuan'),
              content: Text(
                  'Ada pengendara dengan nomor kendaraan ${data['nomorKendaraan']} yang ingin parkir. Apakah anda ingin menerima?'),
              actions: [
                TextButton(
                  onPressed: () {
                    _saveDiterima(data);
                    Navigator.pop(context);
                  },
                  child: const Text('DITERIMA',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    _setDitolak(data);
                    Navigator.pop(context);
                  },
                  child: const Text('DITOLAK'),
                ),
              ],
            );
          },
        );
      }
    };
    clientWrapper.onSubscribed = (() {
      if (kDebugMode) {
        print('subscribed');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    clientWrapper.disconnect();
    super.dispose();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(children: [
            SizedBox(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 1,
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
                        color: warna,
                      ),
                    ),
                  ),
                  Text(
                    'Detail Parkiran',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: warna),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.433,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(warna)),
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Pendapatan();
                                }));
                              },
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.circleDollarToSlot,
                                  size: 28,
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              width: MediaQuery.of(context).size.width * 0.4875,
              height: MediaQuery.of(context).size.height * 0.237,
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      width: MediaQuery.of(context).size.width * 0.477,
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '${dotenv.env['API']}${widget.foto.replaceFirst(RegExp(r'^public'), '')}',
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.146,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                            backgroundColor: MaterialStateProperty.all(warna)),
                        onPressed: () {},
                        child: const Icon(Icons.camera_alt_rounded,
                            color: Colors.white)),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 79),
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: warna),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.nama,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: warna),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 66),
                            child: Text(
                              'Alamat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: warna),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.alamat,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17,
                                  color: warna),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 44),
                            child: Text(
                              'Koordinat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: warna),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.koordinat,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17,
                                  color: warna),
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return QrGenerate();
                          // }));
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.21,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromRGBO(217, 240, 255, 1)),
                              ),
                            ),
                            Image.asset('assets/qrCode.png',
                                width: 200, height: 200),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Generate Qr Code'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.21,
                              height: MediaQuery.of(context).size.height * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(217, 240, 255, 1)),
                            ),
                          ),
                          Image.asset('assets/download.png',
                              width: 200, height: 200),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text('Download Qr Code'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ParkirFloatButton(),
      bottomNavigationBar: const ParkirBotNav(),
    );
  }
}
