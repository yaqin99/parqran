import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';

class DetailMotor extends StatefulWidget {
  final String nama;
  final String merk;
  final String warna;
  final String no_registrasi;
  final String no_stnk;
  final String no_rangka;
  final String foto;
  const DetailMotor({
    Key? key,
    required this.nama,
    required this.merk,
    required this.warna,
    required this.no_registrasi,
    required this.no_stnk,
    required this.no_rangka,
    required this.foto,
  }) : super(key: key);
  @override
  State<DetailMotor> createState() => _DetailMotorState();
}

class _DetailMotorState extends State<DetailMotor> {
  bool hold = false;
  Color warna = Colors.transparent;

  @override
  void initState() {
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(children: [
            SizedBox(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Color.fromRGBO(52, 152, 219, 1),
                  ),
                ),
              ),
              const Text(
                'Detail Motor',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(52, 152, 219, 1)),
              ),
                ],
              ),
            ),
            SizedBox(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              width: MediaQuery.of(context).size.width * 0.4875,
              height: MediaQuery.of(context).size.height * 0.237,
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      width: MediaQuery.of(context).size.width * 0.477,
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                              '${dotenv.env['API']}${widget.foto.replaceFirst(RegExp(r'^public'), '')}')),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.146,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(52, 152, 219, 1))),
                        onPressed: () {},
                        child: const Icon(Icons.camera_alt_rounded,
                            color: Colors.white)),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.4,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 77),
                            child: Text(
                              'Merk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text('${widget.merk} ${widget.nama}',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 66),
                            child: Text(
                              'Warna',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            widget.warna,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 41),
                            child: Text(
                              'No. Polisi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            widget.no_registrasi,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 38),
                            child: Text(
                              'No. STNK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            widget.no_stnk,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Text(
                              'No. Rangka',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromRGBO(52, 152, 219, 1)),
                            ),
                          ),
                          Text(
                            widget.no_rangka,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                                color: Color.fromRGBO(52, 152, 219, 1)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FLoatButton(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
