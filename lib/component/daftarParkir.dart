import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DaftarParkir extends StatefulWidget {
  const DaftarParkir({Key? key}) : super(key: key);

  @override
  State<DaftarParkir> createState() => _DaftarParkirState();
}

class _DaftarParkirState extends State<DaftarParkir> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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
                            color: Color.fromRGBO(155, 89, 182, 1), width: 3),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {},
                  child: Center(
                      child: FaIcon(
                    FontAwesomeIcons.motorcycle,
                    color: Color.fromRGBO(155, 89, 182, 1),
                    size: 40,
                  ))),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yamaha Mio',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(155, 89, 182, 1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11, bottom: 11),
                    child: Text(
                      'M 3345 AB',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromRGBO(155, 89, 182, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
