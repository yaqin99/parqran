import 'package:dio/dio.dart';

import 'person.dart';
import 'package:flutter/material.dart';

abstract class Services {
  static Future<Person?> postDataUser(
      String email, String nama, String foto) async {
    try {
      var data = await Dio().post('http://192.168.43.95:3000/auth', data: {
        'email': email,
        'nama': nama,
        'foto': foto,
      });
      return Person(
          email: data.data['data'][0]['email'],
          nama: data.data['data'][0]['nama'],
          foto: data.data['data'][0]['foto']);
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }
}
