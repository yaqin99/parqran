import 'package:flutter/cupertino.dart';

class MapProv extends ChangeNotifier {
  // int id;
  // String name;
  // String email;
  // String avatar;

  double lati = 1;
  double longi = 2;

  double get getLatitude => lati;
  double get getLongi => longi;

  setMap(double latitude, double longitude) {
    this.lati = latitude;
    this.longi = longitude;
    notifyListeners();
  }
}
