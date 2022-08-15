import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class Services {
  static Future postDataUser(String email, String nama, String foto) async {
    try {
      var data = await Dio().post('http://192.168.1.110:8080/auth', data: {
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

  static GraphQLClient? client;

  static _checkGraphql() {
    final HttpLink httpLink = HttpLink('http://192.168.1.110:8080/graphql');
    client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  static Future<QueryResult> gqlQuery(QueryOptions query) {
    _checkGraphql();
    return client!.query(query);
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
          await Dio().post('http://192.168.1.110:8080/vehicle', data: {
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
