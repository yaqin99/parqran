import 'package:dio/dio.dart';

abstract class Services {
  static Future postDataUser(String email, String nama, String foto) async {
    try {
      var data = await Dio().post('http://10.0.15.31:8080/auth', data: {
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
