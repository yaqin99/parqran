import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class Services {
  static Future postDataUser(String email, String nama, String foto) async {
    print('sending data');
    try {
      var data = await Dio().post('${dotenv.env['API']!}/auth', data: {
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

  static Future postParkiran(String id_pengguna, String nama, String alamat,
      String koordinat, String jamBuka, String jamTutup) async {
    try {
      var data = await Dio().post('${dotenv.env['API']!}/parking', data: {
        'id_pengguna': id_pengguna,
        'nama': nama,
        'alamat': alamat,
        'koordinat': koordinat,
        'jam_buka': jamBuka,
        'jam_tutup': jamTutup,
      });
      print(data.data);
      return data.data['data'];
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }

  static Future deleteKendaraan(int idKendaraan) async {
    print('deleting data ...');
    try {
      var data = await Dio()
          .delete('${dotenv.env['API']!}/vehicle/' + idKendaraan.toString());
      print(data);
      return data.data['data'];
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }

  static GraphQLClient? client;

  static _checkGraphql() {
    final HttpLink httpLink = HttpLink('${dotenv.env['API']!}/graphql');
    client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  static Future<QueryResult> gqlQuery(QueryOptions query) {
    _checkGraphql();
    return client!.query(query);
  }
}

abstract class AddKendaraan {
  static Future postDataKendaraan(
      int idPengguna,
      String jenis,
      String nama,
      String merk,
      String warna,
      String noRegistrasi,
      String noRangka,
      String noStnk,
      String fotoKendaraan,
      String fotoStnk) async {
    try {
      var vehicle = await Dio().post('${dotenv.env['API']!}/vehicle', data: {
        'id_pengguna': idPengguna,
        'jenis': jenis,
        'nama': nama,
        'merk': merk,
        'warna': warna,
        'no_registrasi': noRegistrasi,
        'no_rangka': noRangka,
        'no_stnk': noStnk,
        'foto_kendaraan': fotoKendaraan,
        'foto_stnk': fotoStnk,
      });
      print(vehicle.data);
      return vehicle.data;
    } catch (e) {
      print(e);
      // throw ExcReption(e.toString());
    }
  }
}
