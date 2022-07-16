import 'package:flutter/material.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';

import '../component/logo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  onPressed: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainMenu()),
                    );
                  },
                 child: Center(child: Text('Pemilik Kendaraan', style: TextStyle(color:Colors.white , fontSize: 20)))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: (){
                       
                    },
                   child: Center(child: Text('Pemilik Parkir', style: TextStyle(color:Colors.white , fontSize: 20)))),
                ),
              )
        ],
      ),
    );
  }
}