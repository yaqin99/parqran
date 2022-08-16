import 'package:flutter/cupertino.dart';

class Kendaraan extends ChangeNotifier {
  String nama = '';
  String merk = '';
  String warna = '';
  String no_registrasi = '';
  String no_rangka = '';
  String no_stnk = '';
  String tipe = '';
  String foto = '';

  String get getEmail => warna;
  String get getNama => nama;
  String get getFoto => foto;
  String get getNoRegistrasi => no_registrasi;
  String get getNoStnk => no_stnk;
  String get getNoRangka => no_rangka;

  setKendaraan(String nama, String merk, String warna, String no_registrasi,
      String no_rangka, String no_stnk, String tipe, String foto) {
    this.nama = nama;
    this.merk = merk;
    this.warna = warna;
    this.no_registrasi = no_registrasi;
    this.no_stnk = no_stnk;
    this.no_rangka = no_rangka;
    this.tipe = tipe;
    this.foto = foto;
    notifyListeners();
  }
}
