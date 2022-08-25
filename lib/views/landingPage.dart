import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parqran/component/logo.dart';
import 'package:parqran/model/services.dart';
import 'package:parqran/views/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../model/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            title: const Text('Are you sure want to Exit?'),
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool succeed = false;
  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _currentUser = _googleSignIn.currentUser;
      // _prefs.then((prefs) {
        
      // });
    } catch (error) {
      print(error);
    }
  }

  void setProviderAndGo(SharedPreferences pref) {
    Provider.of<Person>(context, listen: false).setPerson(
      int.parse(pref.getString('idUser')!), pref.getString('email')!, pref.getString('nama')!, pref.getString('foto')!
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  void initState() {
    // _checkAcc();

    _googleSignIn.onCurrentUserChanged.listen((event) {
      _currentUser = event;
      _googleSignIn.signInSilently();
    });

    _prefs.then((SharedPreferences pref) {
      if (pref.getString('email') != null) {
        setProviderAndGo(pref);
      }
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.65,
                child: const Logo(),
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
                          const Color.fromRGBO(52, 152, 219, 1)),
                    ),
                    onPressed: () async {
                      await _handleSignIn();
                      final SharedPreferences prefs = await _prefs;
                      if (_currentUser == null) {
                        print('User Not Signed In');
                        return;
                      }
                      
                      final response = await Services.postDataUser(
                          _currentUser!.email,
                          _currentUser!.displayName!,
                          _currentUser!.photoUrl!);

                      prefs.setString('idUser', response['id_pengguna'].toString());
                      prefs.setString('email', _currentUser!.email);
                      prefs.setString('nama', _currentUser!.displayName!);
                      prefs.setString('foto', _currentUser!.photoUrl!);

                      setProviderAndGo(prefs);

                      // masukkan ke provider
                      Provider.of<Person>(context, listen: false).setPerson(
                          response['id_pengguna'],
                          _currentUser!.email,
                          _currentUser!.displayName!,
                          _currentUser!.photoUrl!);

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return _currentUser != null
                            ? Home()
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
          )),
    );
  }
}
