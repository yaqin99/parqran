import 'package:dio/dio.dart';

import 'person.dart';
import 'package:flutter/material.dart';

abstract class Services {
  static Future postDataUser(String email, String nama, String foto) async {
    try {
      var data = await Dio().post('http://192.168.114.79:8080/auth', data: {
        'email': email,
        'nama': nama,
        'foto': foto,
      });
      print(data.data['data'][0]['id_pengguna']);

      return data.data['data'][0];
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }
}
