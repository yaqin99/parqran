import 'package:flutter/cupertino.dart';

import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';

class LoginData extends ChangeNotifier {
  String email;
  String nama;
  String foto;

  LoginData({required this.email, required this.nama, required this.foto});

  void emailInit(String value) {
    this.email = value;
    notifyListeners();
  }

  void namaInit(String value) {
    this.nama = value;
    notifyListeners();
  }

  void fotoInit(String value) {
    this.foto = value;
    notifyListeners();
  }
}
