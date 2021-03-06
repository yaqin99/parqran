import 'package:flutter/material.dart';
import 'package:parqran/component/logo.dart';
import 'package:parqran/views/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

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
  bool succeed = false;
  Future<void> _handleSignIn() async {
    try {
      succeed = true;
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });
    _googleSignIn.signInSilently();
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
                  onPressed: () {
                    _handleSignIn();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return (_currentUser != null) ? Home() : LandingPage();
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
            IconButton(
                onPressed: () {
                  _googleSignIn.disconnect();
                  setState(() {});
                },
                icon: Icon(Icons.logout)),
          ],
        ),
      )),
    );
  }
}
