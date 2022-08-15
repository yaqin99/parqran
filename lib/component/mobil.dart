import 'package:flutter/material.dart';

class Mobil extends StatelessWidget {
  final String nama;
  final String noPol;
  final String noStnk;
  const Mobil({
    Key? key,
    required this.nama,
    required this.noPol,
    required this.noStnk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 3)),
      height: MediaQuery.of(context).size.height * 0.1524,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(217, 240, 255, 1)),
                        height: MediaQuery.of(context).size.height * 0.135,
                        width: MediaQuery.of(context).size.width * 0.295,
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset(
                          'assets/carnew.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(52, 152, 219, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Text(
                        noPol,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(52, 152, 219, 1)),
                      ),
                    ),
                    Text(
                      noStnk,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(52, 152, 219, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }
}
