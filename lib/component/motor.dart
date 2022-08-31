import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Motor extends StatelessWidget {
  final String nama;
  final String noPol;
  final String warna;
  final String foto;
  const Motor({
    Key? key,
    required this.nama,
    required this.noPol,
    required this.warna,
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
                    Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            '${dotenv.env['API']}${foto.replaceFirst(RegExp(r'^public'), '')}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
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
                      nama,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(52, 152, 219, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Text(
                        noPol,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(52, 152, 219, 1)),
                      ),
                    ),
                    Text(
                      warna,
                      style: const TextStyle(
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
