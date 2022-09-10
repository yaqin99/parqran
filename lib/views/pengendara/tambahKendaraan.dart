import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import '../../model/person.dart';
import 'package:provider/provider.dart';
import '../../model/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';

class TambahKendaraan extends StatefulWidget {
  final bool isEdit;
  final bool isMobil;
  final String namaEdit;
  final String merkEdit;
  final String warnaEdit;
  final String noPolEdit;
  final String noStnkEdit;
  final String noRangkaEdit;
  final int idKendaraan;
  final String fotoKendaraanEdit;
  final String fotoStnkEdit;
  const TambahKendaraan({
    Key? key,
    required this.isMobil,
    required this.isEdit,
    required this.namaEdit,
    required this.merkEdit,
    required this.warnaEdit,
    required this.noPolEdit,
    required this.noStnkEdit,
    required this.noRangkaEdit,
    required this.idKendaraan,
    required this.fotoKendaraanEdit,
    required this.fotoStnkEdit,
  }) : super(key: key);
  @override
  State<TambahKendaraan> createState() => _TambahKendaraanState();
}

class _TambahKendaraanState extends State<TambahKendaraan> {
  bool hold = false;
  TextEditingController nama = new TextEditingController();
  TextEditingController merk = new TextEditingController();
  TextEditingController warna = new TextEditingController();
  String? tipe;
  TextEditingController noRegistrasi = new TextEditingController();
  TextEditingController noStnk = new TextEditingController();
  TextEditingController noRangka = new TextEditingController();
  String? foto;
  bool tipeKendaraanMotor = false;
  bool tipeKendaraanMobil = false;
  Color motorText = Color.fromRGBO(52, 152, 219, 1);
  Color mobilText = Color.fromRGBO(52, 152, 219, 1);
  Color? warnaMotorButton;
  Color? warnaMobilButton;
  File? fotoKendaraan;
  File? fotoStnk;
  String stnkName = '';
  String? fotoKendaraanPath;
  String? fotoStnkPath;
  var response;

  initFotoValue() {
    if (widget.fotoKendaraanEdit != '') {
      fotoKendaraanPath = widget.fotoKendaraanEdit;
      print(fotoKendaraanPath);
    }
    if (widget.fotoStnkEdit != '') {
      fotoStnkPath = widget.fotoStnkEdit;
      print(fotoStnkPath);
    }
  }

  File? imageCamera;
  Future _getImageCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    fotoKendaraan = File(imagePicked!.path);
    uploadImage(fotoKendaraan!);
    setState(() {});
  }

  Future _getImageGalery() async {
    fotoKendaraan = null;
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
      fotoKendaraan = File(imagePicked.files.first.path!);
      uploadImage(fotoKendaraan!);
    }

    setState(() {});
  }

  Future _getStnkPict() async {
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
      fotoStnk = File(imagePicked.files.first.path!);
      uploadStnk(fotoStnk!);
    }
    uploadStnk(fotoStnk!);
    setState(() {});
  }

  uploadStnk(File file) async {
    String fileName = file.path.split('/').last;
    stnkName = fileName;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType("image", "jpeg")),
    });
    response = await Dio().post('${dotenv.env['API']!}/fl', data: formData);
    var jsonValue = jsonDecode(response.toString());
    setState(() {});
    return fotoStnkPath = jsonValue['path'].toString();
  }

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType("image", "jpeg")),
    });
    response = await Dio().post('${dotenv.env['API']!}/fl', data: formData);
    var jsonValue = jsonDecode(response.toString());
    return fotoKendaraanPath = jsonValue['path'].toString();
  }

  postVehicle() async {
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();

    if (fotoKendaraan == null) {
      if (widget.fotoKendaraanEdit != '') {}
      if (widget.fotoKendaraanEdit == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Foto Kendaraan tidak boleh kosong'),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ));
      }
    }
    if (fotoStnk == null) {
      if (widget.fotoStnkEdit != '') {}
      if (widget.fotoStnkEdit == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Foto Stnk tidak boleh kosong'),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ));
      }
    }

    if (widget.isEdit == true) {
      response = await Services.updateKendaraan(
        int.parse(idPengguna),
        tipe!,
        nama.text,
        merk.text,
        warna.text,
        noRegistrasi.text,
        noRangka.text,
        noStnk.text,
        fotoKendaraanPath!,
        fotoStnkPath!,
        widget.idKendaraan,
      );
      setState(() {
        nama.text = '';

        merk.text = '';
        warna.text = '';
        noRegistrasi.text = '';
        noRangka.text = '';
        noStnk.text = '';
        (tipe == '0')
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                return const DaftarMotor();
              }))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                return const DaftarMobil();
              }));
      });
    }

    if (widget.isEdit == false) {
      if (nama.text.isEmpty ||
          merk.text.isEmpty ||
          warna.text.isEmpty ||
          noRegistrasi.text.isEmpty ||
          noRangka.text.isEmpty ||
          noStnk.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Mohon lengkapi Semua Data'),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ));
        return;
      }
    }
    if (widget.isEdit == true) {
      if (nama.text.isEmpty ||
          merk.text.isEmpty ||
          warna.text.isEmpty ||
          noRegistrasi.text.isEmpty ||
          noRangka.text.isEmpty ||
          noStnk.text.isEmpty) {
        return;
      }
    }

    if (fotoKendaraan != null && fotoStnk != null) {
      if (nama.text.isNotEmpty ||
          merk.text.isNotEmpty ||
          warna.text.isNotEmpty ||
          noRegistrasi.text.isNotEmpty ||
          noRangka.text.isNotEmpty ||
          noStnk.text.isNotEmpty) {
        if (widget.isEdit == false) {
          response = await AddKendaraan.postDataKendaraan(
            int.parse(idPengguna),
            tipe!,
            nama.text,
            merk.text,
            warna.text,
            noRegistrasi.text,
            noRangka.text,
            noStnk.text,
            fotoKendaraanPath!,
            fotoStnkPath!,
          );

          setState(() {
            nama.text = '';

            merk.text = '';
            warna.text = '';
            noRegistrasi.text = '';
            noRangka.text = '';
            noStnk.text = '';
            (tipe == '0')
                ? Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                    return const DaftarMotor();
                  }))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                    return const DaftarMobil();
                  }));
          });
        }
      }
    }
  }

  initValue() {
    if (widget.isEdit == true) {
      nama.text = widget.namaEdit;
      merk.text = widget.merkEdit;
      warna.text = widget.warnaEdit;
      noRegistrasi.text = widget.noPolEdit;
      noRangka.text = widget.noRangkaEdit;
      noStnk.text = widget.noStnkEdit;
    }
  }

  bool filePicked = false;
  String? imagePath;

  setTipe() {
    if (widget.isMobil == false) {
      tipe = '0';
      print(tipe);
    }
    if (widget.isMobil == true) {
      tipe = '1';
      print(tipe);
    }
    print(widget.idKendaraan);
  }

  @override
  void initState() {
    initFotoValue();
    initValue();
    setTipe();
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
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
                              color: Color.fromRGBO(52, 152, 219, 1),
                            ),
                          ),
                        ),
                        Text(
                          'Tambah Kendaraan',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(52, 152, 219, 1)),
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
                          (fotoKendaraan != null)
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.477,
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:
                                        Image.file(File(fotoKendaraan!.path)),
                                  ))
                              : (widget.fotoKendaraanEdit != '')
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.477,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                            '${dotenv.env['API']}${widget.fotoKendaraanEdit.replaceFirst(RegExp(r'^public'), '')}'),
                                      ),
                                    )
                                  : Container(
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
                                                  color: Color.fromRGBO(
                                                      52, 152, 219, 1),
                                                  width: 3),
                                            )),
                                          ),
                                          onPressed: () {},
                                          child: FaIcon(
                                            (widget.isMobil == false)
                                                ? FontAwesomeIcons.motorcycle
                                                : FontAwesomeIcons.car,
                                            size: 100,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          )),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(52, 152, 219, 1))),
                              onPressed: () {
                                _getImageGalery();
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 62),
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
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
                                      padding: const EdgeInsets.only(right: 66),
                                      child: Text(
                                        'Merk',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: merk,
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
                                      padding: const EdgeInsets.only(right: 57),
                                      child: Text(
                                        'Warna',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: warna,
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
                                    const Padding(
                                      padding: EdgeInsets.only(right: 32),
                                      child: Text(
                                        'No. Polisi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: noRegistrasi,
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
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Text(
                                        'No. Stnk',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: noStnk,
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
                                margin: const EdgeInsets.only(top: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 17),
                                      child: Text(
                                        'No. Rangka',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: TextField(
                                        controller: noRangka,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
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
                                    const Padding(
                                      padding: EdgeInsets.only(right: 33),
                                      child: Text(
                                        'Foto Stnk',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Color.fromRGBO(
                                                52, 152, 219, 1)),
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
                                                              .all(const Color
                                                                      .fromRGBO(
                                                                  52,
                                                                  152,
                                                                  219,
                                                                  1))),
                                                  onPressed: () {
                                                    _getStnkPict();
                                                  },
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text('Tambah Foto',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20)),
                                                      Icon(
                                                          Icons
                                                              .camera_alt_rounded,
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
                                      child: (widget.isEdit == true)
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromRGBO(
                                                              52, 152, 219, 1))),
                                              onPressed: () {
                                                postVehicle();
                                              },
                                              child: const Center(
                                                  child: Text('Update',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700))))
                                          : ElevatedButton(
                                              style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), backgroundColor: MaterialStateProperty.all(Color.fromRGBO(52, 152, 219, 1))),
                                              onPressed: () {
                                                postVehicle();
                                              },
                                              child: const Center(child: Text('Tambah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))),
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
      floatingActionButton: FLoatButton(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
