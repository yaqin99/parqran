import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pemilikParkir/daftarParkiran.dart';
import 'package:parqran/views/pemilikParkir/map.dart';
import '../../model/person.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class TambahParkiran extends StatefulWidget {
  final String koordinat;
  final bool isEdit;
  final String namaParkiran;
  final String alamatParkiran;
  final String jamBukaParkiran;
  final String jamTutupParkiran;
  final String foto;
  final int idParkiranEdit;
  const TambahParkiran(
      {Key? key,
      required this.koordinat,
      required this.isEdit,
      required this.namaParkiran,
      required this.alamatParkiran,
      required this.jamBukaParkiran,
      required this.jamTutupParkiran,
      required this.foto,
      required this.idParkiranEdit})
      : super(key: key);
  @override
  State<TambahParkiran> createState() => _TambahParkiranState();
}

class _TambahParkiranState extends State<TambahParkiran> {
  bool hold = false;
  TextEditingController timeinput = TextEditingController();
  TextEditingController jamTutupText = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay jamTutup = TimeOfDay.now();
  double? latitude;
  double? longitude;
  File? fotoParkiran;
  String? fotoParkiranPath;
  initFormValue() {
    if (widget.isEdit == true) {
      timeinput.text = widget.jamBukaParkiran;
      jamTutupText.text = widget.jamTutupParkiran;
      nama.text = widget.namaParkiran;
      alamat.text = widget.alamatParkiran;
      fotoParkiranPath = widget.foto;
    }
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
        timeinput.text = '${selectedTime.hour}.${selectedTime.minute}';
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
        jamTutupText.text = '${jamTutup.hour}.${jamTutup.minute}';
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

  Color warna = const Color.fromRGBO(155, 89, 182, 1);

  var result;

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType("image", "jpeg")),
    });
    var response = await Dio().post('${dotenv.env['API']!}/fl', data: formData);
    var jsonValue = jsonDecode(response.toString());
    return fotoParkiranPath = jsonValue['path'].toString();
  }

  Future _getImageGalery() async {
    fotoParkiran = null;
    FilePickerResult? imagePicked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png"],
    );
    if (imagePicked!.files.first.size > 1000000) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ukuran Gambar Terlalu Besar'),
        action: SnackBarAction(label: 'Ok', onPressed: () {}),
      ));
    }
    if (imagePicked.files.first.size < 1000000) {
      fotoParkiran = File(imagePicked.files.first.path!);
      uploadImage(fotoParkiran!);
    }

    Navigator.of(context, rootNavigator: true).pop();

    setState(() {});
  }

  postParkiran() async {
    String lokasi = latitude.toString() + longitude.toString();
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    String buka = '${selectedTime.hour}:${selectedTime.minute}';
    String tutup = '${jamTutup.hour}:${jamTutup.minute}';

    if (widget.isEdit == false) {
      result = await Services.postParkiran(
        int.parse(idPengguna),
        nama.text,
        alamat.text,
        lokasi,
        buka,
        tutup,
        fotoParkiranPath!,
      );
      setState(() {
        nama.text = '';
        alamat.text = '';

        timeinput.text = '';
        jamTutupText.text = '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const DaftarParkiran();
        }));
      });
    }
    if (widget.isEdit == true) {
      result = await Services.updateParkiran(
          int.parse(idPengguna),
          nama.text,
          alamat.text,
          lokasi,
          buka,
          tutup,
          fotoParkiranPath!,
          widget.idParkiranEdit);
      setState(() {
        nama.text = '';
        alamat.text = '';

        timeinput.text = '';
        jamTutupText.text = '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const DaftarParkiran();
        }));
      });
    }
  }

  @override
  void initState() {
    _determinePosition();
    initFormValue();
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    // final double lati = Provider.of<MapProv>(context, listen: false).lati;
    // final double longi = Provider.of<MapProv>(context, listen: false).longi;

    return Scaffold(
      body: Center(
        child: SizedBox(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(children: [
            ListView(children: [
              Column(
                children: [
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
                          (widget.isEdit == true)
                              ? 'Update Parkiran'
                              : 'Tambah Parkiran',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: warna),
                        ),
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
                          (widget.isEdit == true)
                              ? (fotoParkiran == null)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.477,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          '${dotenv.env['API']}${widget.foto.replaceFirst(RegExp(r'^public'), '')}',
                                        ),
                                      ))
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.477,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                            File(fotoParkiran!.path)),
                                      ))
                              : (fotoParkiran != null)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.477,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                            File(fotoParkiran!.path)),
                                      ))
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.477,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              side: BorderSide(
                                                  color: warna, width: 3),
                                            )),
                                          ),
                                          onPressed: () {},
                                          child: Image.asset('assets/map.png')),
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
                                  backgroundColor:
                                      MaterialStateProperty.all(warna)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Text('Pilih Opsi'),
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.14,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  _getImageGalery();
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.315,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 15),
                                                        child: Image.asset(
                                                          'assets/folder.png',
                                                          width: 150,
                                                          height: 150,
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom: 17,
                                                          left: 31,
                                                          child: Text(
                                                              'Pilih File'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // await _getImageCamera();
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.315,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 15),
                                                        child: Image.asset(
                                                          'assets/camera.png',
                                                          width: 150,
                                                          height: 150,
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom: 17,
                                                          left: 18,
                                                          child: Text(
                                                              'Buka Kamera'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: const Icon(Icons.camera_alt_rounded,
                                  color: Colors.white)),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Row(
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
                                            borderSide: const BorderSide(
                                                color: Colors.brown),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          hintStyle: const TextStyle(
                                              color: Colors.pink),
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.pink),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                            SizedBox(
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
                                                    children: const [
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
                                margin: const EdgeInsets.only(top: 30),
                                width:
                                    MediaQuery.of(context).size.width * 0.950,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.469,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      child: (widget.isEdit == true)
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          warna)),
                                              onPressed: () {
                                                postParkiran();
                                              },
                                              child: const Center(
                                                  child: Text('Update',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w700))))
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                  backgroundColor: MaterialStateProperty.all(warna)),
                                              onPressed: () {
                                                postParkiran();
                                              },
                                              child: const Center(child: Text('Tambah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.469,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              SizedBox(
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
      floatingActionButton: const ParkirFloatButton(),
      bottomNavigationBar: const ParkirBotNav(),
    );
  }
}
