import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parqran/views/pengendara/daftarMobil.dart';
import 'package:parqran/views/pengendara/daftarMotor.dart';
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:parqran/views/pengendara/pinjamKendaraan.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Color.fromRGBO(52, 152, 219, 1),
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
                          return MainMenu();
                        }));
                      },
                      icon:
                          FaIcon(FontAwesomeIcons.house, color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return DaftarMotor();
                        }));
                      },
                      icon: FaIcon(FontAwesomeIcons.motorcycle,
                          color: Colors.white)),
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
                          return DaftarMobil();
                        }));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.carSide,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PinjamKendaraan();
                        }));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.handshake,
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
