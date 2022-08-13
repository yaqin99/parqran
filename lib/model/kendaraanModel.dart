class Kendaraan {
  String? nama;
  String? merk;

  Kendaraan(this.nama, this.merk);

  Kendaraan.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    merk = json['merk'];
  }
}
