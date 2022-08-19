import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/mapProv.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/landingPage.dart';
import 'package:parqran/views/pemilikParkir/map.dart';
import 'package:parqran/views/pengendara/loadingPage.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

class TambahParkiran extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String namaParkiran;
  final String alamatParkiran;
  final String jamBukaParkiran;
  final String jamTutupParkiran;
  const TambahParkiran(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.namaParkiran,
      required this.alamatParkiran,
      required this.jamBukaParkiran,
      required this.jamTutupParkiran})
      : super(key: key);
  @override
  State<TambahParkiran> createState() => _TambahParkiranState();
}

class _TambahParkiranState extends State<TambahParkiran> {
  bool hold = false;
  TextEditingController timeinput = new TextEditingController();
  TextEditingController jamTutupText = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay jamTutup = TimeOfDay.now();
  double? latitude;
  double? longitude;
  _initFormValue() {
    timeinput.text = widget.jamBukaParkiran;
    jamTutupText.text = widget.jamTutupParkiran;
    nama.text = widget.namaParkiran;
    alamat.text = widget.alamatParkiran;
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;

        timeinput.text = selectedTime.hour.toString() +
            '.' +
            selectedTime.minute.toString() +
            ' WIB';
      });
    }
    print(selectedTime.hour);
  }

  _getJamTutup(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: jamTutup,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        jamTutup = timeOfDay;

        jamTutupText.text = jamTutup.hour.toString() +
            '.' +
            jamTutup.minute.toString() +
            ' WIB';
      });
    }
  }

  Future<Position> _determinePosition() async {
    Position lokasi;
    bool serviceEnabled;
    LocationPermission permission;

    String? _selectedTime;
    TimeOfDay selectedTime = TimeOfDay.now();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    lokasi = await Geolocator.getCurrentPosition();
    latitude = lokasi.latitude;
    longitude = lokasi.longitude;

    setState(() {});

    return lokasi;
  }

  Color warna = Color.fromRGBO(155, 89, 182, 1);

  var result;
  postParkiran() async {
    String lokasi = latitude.toString() + longitude.toString();
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    String buka =
        selectedTime.hour.toString() + ':' + selectedTime.minute.toString();
    String tutup = jamTutup.hour.toString() + ':' + jamTutup.minute.toString();
    // print({
    //   'id_pengguna': idPengguna,
    //   'nama': nama.text,
    //   'alamat': alamat.text,
    //   'lokasi': lokasi,
    //   'buka': buka,
    //   'tutup': tutup,
    // });
    result = await Services.postParkiran(
      idPengguna,
      nama.text,
      alamat.text,
      lokasi,
      buka,
      tutup,
    );

    setState(() {
      nama.text = '';
      alamat.text = '';

      timeinput.text = '';
      jamTutupText.text = '';
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    _determinePosition();
    // TODO: implement initState
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    // final double lati = Provider.of<MapProv>(context, listen: false).lati;
    // final double longi = Provider.of<MapProv>(context, listen: false).longi;

    return Scaffold(
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(children: [
            ListView(children: [
              Column(
                children: [
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
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
                              color: warna,
                            ),
                          ),
                        ),
                        Text(
                          'Tambah Parkiran',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: warna),
                        ),
                      ],
                    )),
                  ),
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4875,
                    height: MediaQuery.of(context).size.height * 0.237,
                    child: Stack(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.477,
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(255, 255, 255, 1)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    side: BorderSide(color: warna, width: 3),
                                  )),
                                ),
                                onPressed: () {},
                                child: Image.asset('assets/map.png')),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.146,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(warna)),
                              onPressed: () {},
                              child: Icon(Icons.camera_alt_rounded,
                                  color: Colors.white)),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 62),
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: nama,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 51),
                                      child: Text(
                                        'Alamat',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: alamat,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Text(
                                        'Jam Buka',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: timeinput,
                                        readOnly: true,
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 22),
                                      child: Text(
                                        'Jam Tutup',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: jamTutupText,
                                        readOnly: true,
                                        onTap: () {
                                          _getJamTutup(context);
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                TextStyle(color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Text(
                                        'Koordinat',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.475,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.469,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.075,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(warna)),
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return GetMap(
                                                          namaParkiran:
                                                              nama.text,
                                                          alamatParkiran:
                                                              alamat.text,
                                                          jamBukaParkiran:
                                                              timeinput.text,
                                                          jamTutupParkiran:
                                                              jamTutupText
                                                                  .text);
                                                    }));
                                                  },
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Browse',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                      Icon(Icons.location_on,
                                                          color: Colors.white)
                                                    ],
                                                  ))),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                width:
                                    MediaQuery.of(context).size.width * 0.950,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.469,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      warna)),
                                          onPressed: () {
                                            postParkiran();
                                          },
                                          child: Center(
                                              child: Text('Tambah',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700)))),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ParkirFloatButton(),
      bottomNavigationBar: ParkirBotNav(),
    );
  }
}
