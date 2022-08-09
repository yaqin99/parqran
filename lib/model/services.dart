import 'package:dio/dio.dart';

abstract class Services {
  static Future postDataUser(String email, String nama, String foto) async {
    try {
      var data = await Dio().post('http://192.168.43.95:8080/auth', data: {
        'email': email,
        'nama': nama,
        'foto': foto,
      });
      return data.data['data'];
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }
}

abstract class AddKendaraan {
  static Future postDataKendaraan(
      int id_pengguna,
      String jenis,
      String nama,
      String merk,
      String warna,
      String no_registrasi,
      String no_rangka,
      String no_stnk) async {
    try {
      var vehicle =
          await Dio().post('http://192.168.43.95:8080/vehicle', data: {
        'id_pengguna': id_pengguna,
        'jenis': jenis,
        'nama': nama,
        'merk': merk,
        'warna': warna,
        'no_registrasi': no_registrasi,
        'no_rangka': no_rangka,
        'no_stnk': no_stnk,
      });
      return vehicle.data;
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }
}
