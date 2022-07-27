import 'package:dio/dio.dart';

import 'person.dart';
import 'package:flutter/material.dart';

abstract class Services {
  static Future<Person?> getById() async {
    try {
      var response = await Dio().get('https://reqres.in/api/users/2');
      if (response.statusCode == 200) {
        return Person(
            id: response.data['data']['id'],
            name: response.data['data']['first_name'],
            email: response.data['data']['email']);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
