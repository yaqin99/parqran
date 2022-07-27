import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parqran/model/model.dart';

class Repository {
  final _baseUrl = 'https://62e162eefa99731d75d58fa2.mockapi.io/pengguna/user';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();
        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
