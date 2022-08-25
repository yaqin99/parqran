import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/model/services.dart';
import '../../model/person.dart';
import 'package:provider/provider.dart';
import '../../model/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TambahKendaraan extends StatefulWidget {
  final bool isEdit;
  final bool isMobil;
  final String namaEdit;
  final String merkEdit;
  final String warnaEdit;
  final String noPolEdit;
  final String noStnkEdit;
  final String noRangkaEdit;
  final String idKendaraan;
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
  }) : super(key: key);
  @override
  State<TambahKendaraan> createState() => _TambahKendaraanState();
}

class _TambahKendaraanState extends State<TambahKendaraan> {
  bool hold = false;
  TextEditingController nama = TextEditingController();
  TextEditingController merk = TextEditingController();
  TextEditingController warna = TextEditingController();
  String? tipe;
  TextEditingController noRegistrasi = TextEditingController();
  TextEditingController noStnk = TextEditingController();
  TextEditingController noRangka = TextEditingController();
  String? foto;
  bool tipeKendaraanMotor = false;
  bool tipeKendaraanMobil = false;
  Color motorText = const Color.fromRGBO(52, 152, 219, 1);
  Color mobilText = const Color.fromRGBO(52, 152, 219, 1);
  Color? warnaMotorButton;
  Color? warnaMobilButton;
  var response;
  postVehicle() async {
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    response = await AddKendaraan.postDataKendaraan(
        int.parse(idPengguna),
        tipe!,
        nama.text,
        merk.text,
        warna.text,
        noRegistrasi.text,
        noRangka.text,
        noStnk.text);

    setState(() {
      nama.text = '';
      tipe = '';
      merk.text = '';
      warna.text = '';
      noRegistrasi.text = '';
      noRangka.text = '';
      noStnk.text = '';
      Navigator.pop(context);
    });
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
    initValue();
    setTipe();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        child: const Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Color.fromRGBO(52, 152, 219, 1),
                        ),
                      ),
                    ),
                    const Text(
                      'Tambah Kendaraan',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(52, 152, 219, 1)),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.477,
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(255, 255, 255, 1)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    side: const BorderSide(
                                        color: Color.fromRGBO(52, 152, 219, 1),
                                        width: 3),
                                  )),
                                ),
                                onPressed: () {},
                                child: FaIcon(
                                  (widget.isMobil == false)
                                      ? FontAwesomeIcons.motorcycle
                                      : FontAwesomeIcons.car,
                                  size: 100,
                                  color: const Color.fromRGBO(52, 152, 219, 1),
                                )),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(52, 152, 219, 1))),
                              onPressed: () {},
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
                                            borderSide: const BorderSide(
                                                color: Colors.brown),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          hintStyle:
                                              const TextStyle(color: Colors.pink),
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
                                    const Padding(
                                      padding: EdgeInsets.only(right: 66),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                const TextStyle(color: Colors.pink),
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
                                      padding: EdgeInsets.only(right: 57),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                const TextStyle(color: Colors.pink),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                const TextStyle(color: Colors.pink),
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
                                      padding: EdgeInsets.only(right: 40),
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
                                              borderSide: const BorderSide(
                                                  color: Colors.brown),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle:
                                                const TextStyle(color: Colors.pink),
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
                                                const TextStyle(color: Colors.pink),
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
                                                              .all(const Color
                                                                  .fromRGBO(
                                                                      52,
                                                                      152,
                                                                      219,
                                                                      1))),
                                                  onPressed: () {},
                                                  child: Center(
                                                      child: Row(
                                                    children: const [
                                                      Text('Tambah Foto',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
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
                                                          const Color.fromRGBO(
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
                                              style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(52, 152, 219, 1))),
                                              onPressed: () {
                                                postVehicle();
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
      floatingActionButton: const FLoatButton(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
