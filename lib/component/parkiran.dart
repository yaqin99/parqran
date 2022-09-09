import 'package:flutter/material.dart';

class Parkiran extends StatelessWidget {
  final String lokasi;
  final String areaCode;
  final String foto;

  const Parkiran({
    Key? key,
    required this.lokasi,
    required this.areaCode,
    required this.foto,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(239, 201, 255, 1)),
                        height: MediaQuery.of(context).size.height * 0.135,
                        width: MediaQuery.of(context).size.width * 0.295,
                      ),
                    ),
                    Center(
                      child: Image.network(foto),
                      // child: Image.asset(
                      //   'assets/map2.png',
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lokasi,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(155, 89, 182, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Text(
                        areaCode,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromRGBO(155, 89, 182, 1)),
                      ),
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
