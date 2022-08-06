import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DaftarKendaraan extends StatefulWidget {
  const DaftarKendaraan({Key? key}) : super(key: key);

  @override
  State<DaftarKendaraan> createState() => _DaftarKendaraanState();
}

class _DaftarKendaraanState extends State<DaftarKendaraan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                              color: Color.fromRGBO(52, 152, 219, 1), width: 3),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: Center(
                        child: FaIcon(
                      FontAwesomeIcons.motorcycle,
                      color: Color.fromRGBO(52, 152, 219, 1),
                      size: 40,
                    ))),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yamaha Mio',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromRGBO(52, 152, 219, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Text(
                        'M 3345 AB',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(52, 152, 219, 1)),
                      ),
                    ),
                    Text(
                      'JGSGFG123',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromRGBO(52, 152, 219, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
