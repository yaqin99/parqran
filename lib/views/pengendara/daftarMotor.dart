import 'package:flutter/material.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/motor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DaftarMotor extends StatefulWidget {
  const DaftarMotor({Key? key}) : super(key: key);

  @override
  State<DaftarMotor> createState() => _DaftarMotorState();
}

class _DaftarMotorState extends State<DaftarMotor> {
  bool hold = false;
  Color warna = Colors.transparent;
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Are you sure want to Exit?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('No')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes')),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button Pressed');

        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(children: [
              ListView(
                children: [
                  Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Container(
                          child: (hold == true)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hold = false;
                                          warna = Colors.transparent;
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.xmark,
                                        size: 26,
                                        color: Color.fromRGBO(52, 152, 219, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons
                                                  .photo_size_select_actual_rounded,
                                              size: 26,
                                              color: Color.fromRGBO(
                                                  52, 152, 219, 1),
                                            )),
                                        IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
                                            FontAwesomeIcons.trash,
                                            size: 26,
                                            color:
                                                Color.fromRGBO(52, 152, 219, 1),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 18),
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       Navigator.pop(
                                    //         context,
                                    //       );
                                    //     },
                                    //     child: Icon(
                                    //       Icons.arrow_back,
                                    //       size: 35,
                                    //       color: Color.fromRGBO(52, 152, 219, 1),
                                    //     ),
                                    //   ),
                                    // ),
                                    Text(
                                      'Daftar Motor',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(52, 152, 219, 1)),
                                    ),
                                  ],
                                )),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onLongPressStart: (a) {
                            setState(() {
                              hold = true;
                              warna = Color.fromRGBO(52, 152, 219, 1);
                            });
                          },
                          child: Motor(
                            nama: 'Honda Vario 150',
                            noPol: 'M 333 AB',
                            noMesin: 'AHDKJ213',
                            warna: warna,
                          ),
                        ),
                        GestureDetector(
                          onLongPressStart: (a) {
                            setState(() {
                              hold = true;
                              warna = Color.fromRGBO(52, 152, 219, 1);
                            });
                          },
                          child: Motor(
                            nama: 'Honda Vario 150',
                            noPol: 'M 333 AB',
                            noMesin: 'AHDKJ213',
                            warna: warna,
                          ),
                        ),
                      ],
                    )
                  ])
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(7),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(52, 152, 219, 1))),
                                onPressed: () {},
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FLoatButton(),
        bottomNavigationBar: BottomNavbar(),
      ),
    );
  }
}
