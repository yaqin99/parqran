import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/views/pemilikParkir/PemilikParkirMenu.dart';
import 'package:parqran/views/pemilikParkir/daftarParkiran.dart';
import 'package:parqran/views/pemilikParkir/managementParkir.dart';
import 'package:parqran/views/pemilikParkir/partner.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/pinjamKendaraan.dart';

class ParkirBotNav extends StatefulWidget {
  const ParkirBotNav({Key? key}) : super(key: key);

  @override
  State<ParkirBotNav> createState() => _ParkirBotNavState();
}

class _ParkirBotNavState extends State<ParkirBotNav> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Color.fromRGBO(155, 89, 182, 1),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.412,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const PemilikParkirMenu();
                        }));
                      },
                      icon: const FaIcon(FontAwesomeIcons.house,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const DaftarParkiran();
                        }));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.locationDot,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.17,
              child: Row(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.412,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ManageParkir();
                        }));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.car,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Partner();
                        }));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.userCheck,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
