import 'package:flutter/cupertino.dart';

class Person extends ChangeNotifier {
  // int id;
  // String name;
  // String email;
  // String avatar;

  String email = '';
  String nama = '';
  String foto = '';
  int id_pengguna = 0;

  String get getEmail => email;
  String get getNama => nama;
  String get getFoto => foto;
  int get getIdPengguna => id_pengguna;

  setPerson(int idPengguna, String email, String nama, String foto) {
    this.email = email;
    this.nama = nama;
    this.foto = foto;
    id_pengguna = idPengguna;
    notifyListeners();
  }
}
