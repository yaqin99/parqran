import 'package:flutter/material.dart';
import 'package:parqran/component/logo.dart';
import 'package:parqran/model/loginData.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import '../../model/person.dart';
import '../../model/personCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LandingPage extends StatefulWidget {
  final bool isLogOut;
  const LandingPage({Key? key, required this.isLogOut}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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

  GoogleSignInAccount? _currentUser;
  var response;

  _checkAcc() async {
    final SharedPreferences prefs = await _prefs;

    if (prefs.getBool('accCheck') == true) {
      print(prefs.getBool('accCheck'));
      _googleSignIn.disconnect();
    }
  }

  bool succeed = false;
  Person? person;
  _handleSignIn() async {
    try {
      if (_currentUser == null) {
        await _googleSignIn.signIn();
        print(_currentUser!.displayName);
      }
    } catch (error) {
      print(error);
    }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getData() async {
    final SharedPreferences prefs = await _prefs;

    if (widget.isLogOut == false) {
      print('anda sudah login');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   // return MainMenu(
      //   //     email: prefs.getString('email')!,
      //   //     nama: prefs.getString('nama')!,
      //   //     foto: prefs.getString('foto')!);
      // }));
    }

    ;
  }

  @override
  void initState() {
    // _checkAcc();

    _googleSignIn.onCurrentUserChanged.listen((event) {
      _currentUser = event;

      _googleSignIn.signInSilently();
    });

    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button Pressed');

        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
          body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Logo(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(6),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(52, 152, 219, 1)),
                  ),
                  onPressed: () async {
                    await _handleSignIn();
                    print('Masuk');
                    final SharedPreferences prefs = await _prefs;
                    prefs.setString('email', _currentUser!.email);
                    prefs.setString('nama', _currentUser!.displayName!);
                    prefs.setString('foto', _currentUser!.photoUrl!);

                    response = await Services.postDataUser(_currentUser!.email,
                        _currentUser!.displayName!, _currentUser!.photoUrl!);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return (_currentUser != null)
                          ? Home(
                              email: response['email'],
                              nama: response['nama'],
                              foto: response['foto'],
                              id_pengguna: response['id_pengguna'].toString(),
                            )
                          : LandingPage(isLogOut: false);
                    }));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        ),
                        Text('Sign In With Google',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ])),
            ),
            // IconButton(
            //     onPressed: () {
            //       _googleSignIn.disconnect();
            //       setState(() {});
            //     },
            //     icon: Icon(Icons.logout)),
          ],
        ),
      )),
    );
  }
}
