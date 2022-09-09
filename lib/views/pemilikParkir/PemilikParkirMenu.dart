import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/person.dart';
import 'package:parqran/views/pemilikParkir/daftarParkiran.dart';
import 'package:parqran/views/pemilikParkir/managementParkir.dart';
import 'package:parqran/views/pemilikParkir/partner.dart';
import 'package:parqran/views/pemilikParkir/scan_masuk_parkir.dart';
import 'package:parqran/views/pengendara/profil.dart';
import 'package:provider/provider.dart';

class PemilikParkirMenu extends StatefulWidget {
  const PemilikParkirMenu({Key? key}) : super(key: key);

  @override
  State<PemilikParkirMenu> createState() => _PemilikParkirMenuState();
}

class _PemilikParkirMenuState extends State<PemilikParkirMenu> {
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
        if (kDebugMode) {
          print('Back Button Pressed');
        }

        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
          body: Center(
            child: SizedBox(
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
                                color: Color.fromRGBO(155, 89, 182, 1)),
                          ),
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
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const DaftarParkiran();
                                    }));
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromRGBO(
                                                    239, 201, 255, 1)),
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
                                              Center(
                                                child: Image.asset(
                                                  'assets/map2.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Daftar Parkiran'))
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const ManageParkir();
                                    }));
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromRGBO(
                                                    239, 201, 255, 1)),
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
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Image.asset(
                                                  'assets/carParking.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Jumlah Parkir'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const Partner();
                                    }));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.165,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromRGBO(
                                                    239, 201, 255, 1)),
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
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Image.asset(
                                                  'assets/partner.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text('Partnership'))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  height: MediaQuery.of(context).size.height *
                                      0.165,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
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
                return const ScanMasukParkir();
              }));
            },
            backgroundColor: const Color.fromRGBO(155, 89, 182, 1),
            child: const Icon(Icons.qr_code_scanner, size: 30,),
          ),
          bottomNavigationBar: const ParkirBotNav()),
    );
  }
}
