import 'package:dio/dio.dart';

import 'person.dart';
import 'package:flutter/material.dart';

abstract class Services {
  static Future<Person?> getById(int id) async {
    try {
      var response = await Dio().get('https://reqres.in/api/users/$id');
      if (response.statusCode == 200) {
        return Person(
          id: response.data['data']['id'],
          name: response.data['data']['first_name'],
          email: response.data['data']['email'],
          avatar: response.data['data']['avatar'],
          // id: response.data['id'],
          // name: response.data['first_name'],
          // email: response.data['email']);
        );
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
