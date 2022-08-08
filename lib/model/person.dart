import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Person extends ChangeNotifier {
  // int id;
  // String name;
  // String email;
  // String avatar;

  String? email;
  String? nama;
  String? foto;
  int? id_pengguna;

  setPerson(int id_pengguna, String email, String nama, String foto) {
    this.email = email;
    this.nama = nama;
    this.foto = foto;
    this.id_pengguna = id_pengguna;
    notifyListeners();
  }
}
