import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  factory User.createUser(Map<String, dynamic> object) {
    return User(id: object['id'].toString(), name: object['fisrt_name']);
  }

  static Future<User> connectToApi() async {
    Uri apiUrl = Uri.parse('https://reqres.in/api/users/2');

    var apiResult = await http.get(apiUrl);
    var jsonObject = jsonDecode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}
