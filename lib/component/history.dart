import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  final String lokasi;
  final String masuk;
  final String tanggal;
  final String keluar;

  const History({
    Key? key,
    required this.lokasi,
    required this.masuk,
    required this.tanggal,
    required this.keluar,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 26),
                          child: Text(
                            'Lokasi',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ),
                        Text(
                          lokasi,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromRGBO(52, 152, 219, 1)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 23),
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            masuk,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            'Tanggal',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ),
                        Text(
                          tanggal,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromRGBO(52, 152, 219, 1)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 26),
                            child: Text(
                              'Keluar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            masuk,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                    Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/motorcyclenew.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
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
