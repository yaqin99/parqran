import 'package:flutter/material.dart';
import 'package:parqran/component/logo.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                
                width: MediaQuery.of(context).size.width * 1 ,
                height: MediaQuery.of(context).size.height * 0.65 ,
                
                child: Logo(),
              ), 
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(6),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      
                    )),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(52, 152, 219, 1)),
                  ),
                  onPressed: (){},
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children :[
                    Image.asset('assets/google.png' , width: 40, height: 40, fit: BoxFit.fill,),
                    Text('Sign In With Google', style: TextStyle(color:Colors.white , fontSize: 20)),
                  ]
                )),
              )
            ],
          ),
        )
      );
  }
}