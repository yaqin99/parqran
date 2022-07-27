class User {
  final String name;
  final String id;
  final String jurusan;

  const User({
    required this.name,
    required this.id,
    required this.jurusan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      jurusan: json['jurusan'],
    );
  }
}
