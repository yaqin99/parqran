import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/loadingPage.dart';
import 'package:parqran/views/pengendara/pinjamKendaraan.dart';
import 'package:parqran/views/pengendara/profil.dart';
import 'package:parqran/views/pengendara/scan_masuk.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  QRViewController? controller;
  String? id_pengguna;

  @override
  void initState() {
    super.initState();
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are you sure want to Exit?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes')),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    final String nama = Provider.of<Person>(context, listen: false).nama;
    final String foto = Provider.of<Person>(context, listen: false).foto;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
          body: Center(
            child: (nama.isEmpty)
                ? const LoadingPage()
                : SizedBox(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selamat Datang $nama',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(52, 152, 219, 1)),
                                ),
                                // PersonName(person: person!),
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Profil(addWarna: false),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(foto),
                                        radius: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.41,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const DaftarMotor();
                                          }));
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.165,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          const Color.fromRGBO(
                                                              217,
                                                              240,
                                                              255,
                                                              1)),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.135,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Image.asset(
                                                        'assets/motorcyclenew.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text('Daftar Motor'))
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const DaftarMobil();
                                          }));
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.165,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          const Color.fromRGBO(
                                                              217,
                                                              240,
                                                              255,
                                                              1)),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.135,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Image.asset(
                                                        'assets/carnew.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text('Daftar Mobil'))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const HistoryParkir();
                                          }));
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.165,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          const Color.fromRGBO(
                                                              217,
                                                              240,
                                                              255,
                                                              1)),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.135,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Image.asset(
                                                        'assets/list.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text('History Parkir'))
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const PinjamKendaraan();
                                          }));
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.165,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          const Color.fromRGBO(
                                                              217,
                                                              240,
                                                              255,
                                                              1)),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.135,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Image.asset(
                                                        'assets/pinjam.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child:
                                                      Text('Pinjam Kendaraan'))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const ScanMasuk();
              }));
            },
            backgroundColor: const Color.fromRGBO(155, 89, 182, 1),
            child: const Icon(
              Icons.qr_code_scanner,
              size: 30,
            ),
          ),
          bottomNavigationBar: const BottomNavbar()),
    );
  }
}
