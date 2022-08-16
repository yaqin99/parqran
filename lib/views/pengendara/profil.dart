import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parqran/component/bottomNavbar.dart';
import 'package:parqran/component/floatButton.dart';
import 'package:parqran/component/parkirBottomNavbar.dart';
import 'package:parqran/component/parkirFloatButton.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/landingPage.dart';
import 'package:parqran/views/pengendara/historyParkir.dart';
import 'package:parqran/views/pengendara/loadingPage.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'package:provider/provider.dart';
import 'package:parqran/model/person.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Profil extends StatefulWidget {
  final bool addWarna;
  const Profil({Key? key, required this.addWarna}) : super(key: key);
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool hold = false;

  Color warna = Color.fromRGBO(52, 152, 219, 1);
  colorCheck() {
    if (widget.addWarna == true) {
      warna = Color.fromRGBO(155, 89, 182, 1);
    }
  }

  GoogleSignInAccount? _currentUser;
  Future<void> _logOutGoogle() async {
    try {
      await _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    colorCheck();
    // TODO: implement initState
    super.initState();
  }

  bool textFieldActivated = false;

  @override
  Widget build(BuildContext context) {
    final String nama = Provider.of<Person>(context, listen: false).nama;
    final String foto = Provider.of<Person>(context, listen: false).foto;
    final String email = Provider.of<Person>(context, listen: false).email;
    final String idPengguna =
        Provider.of<Person>(context, listen: false).getIdPengguna.toString();
    return Scaffold(
      body: Center(
        child: (nama == null)
            ? LoadingPage()
            : Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(children: [
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Container(
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
                            child: Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: warna,
                            ),
                          ),
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: warna),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.645,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HistoryParkir();
                                  }));
                                },
                                child: Icon(
                                  Icons.list,
                                  size: 35,
                                  color: warna,
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final SharedPreferences prefs = await _prefs;
                                  prefs.setBool('accCheck', true);
                                  prefs.clear();
                                  _googleSignIn.disconnect();
                                  _googleSignIn.signOut();
                                  // setState(() {});
                                  // Restart.restartApp();
                                  SystemNavigator.pop();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LandingPage(
                                      isLogOut: true,
                                    );
                                  }));
                                },
                                child: Icon(
                                  Icons.logout,
                                  size: 35,
                                  color: warna,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4875,
                    height: MediaQuery.of(context).size.height * 0.237,
                    child: Stack(children: [
                      (foto != null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.477,
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      foto,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.477,
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  52, 152, 219, 1),
                                              width: 3),
                                        )),
                                      ),
                                      onPressed: () {},
                                      child: FaIcon(
                                        FontAwesomeIcons.userLarge,
                                        size: 100,
                                        color: warna,
                                      )),
                                ),
                              ],
                            ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.146,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(warna)),
                              onPressed: () {},
                              child: Icon(Icons.camera_alt_rounded,
                                  color: Colors.white)),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.4,
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 46),
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        nama,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                            color: warna),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 65),
                                      child: Text(
                                        'Nik',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Text(
                                      '35280527349xxx',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17,
                                          color: warna),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 35),
                                      child: Text(
                                        'Alamat',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Text(
                                      'Jl. Sersan Mesrul Gg. 3B',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17,
                                          color: warna),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 47),
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                            color: warna),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text(
                                        'No. Telp',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: warna),
                                      ),
                                    ),
                                    Text(
                                      '085232324069',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17,
                                          color: warna),
                                    ),
                                  ],
                                ),
                              ),
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
      floatingActionButton:
          (widget.addWarna == true) ? ParkirFloatButton() : FLoatButton(),
      bottomNavigationBar:
          (widget.addWarna == true) ? ParkirBotNav() : BottomNavbar(),
    );
  }
}
