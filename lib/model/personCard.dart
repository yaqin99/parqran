import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'person.dart';

class PersonName extends StatelessWidget {
  final Person person;
  const PersonName({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Selamat Datang ${person.nama}',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(52, 152, 219, 1)),
      ),
    );
  }
}

class ProfilName extends StatelessWidget {
  final Person person;
  const ProfilName({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '',
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(52, 152, 219, 1)),
      ),
    );
  }
}

class ProfilId extends StatelessWidget {
  final Person person;
  const ProfilId({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        person.id_pengguna.toString(),
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(52, 152, 219, 1)),
      ),
    );
  }
}

class ProfilEmail extends StatelessWidget {
  final Person person;
  const ProfilEmail({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '',
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(52, 152, 219, 1)),
      ),
    );
  }
}

class ProfilAvatar extends StatelessWidget {
  final Person person;
  const ProfilAvatar({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          width: MediaQuery.of(context).size.width * 0.477,
          height: MediaQuery.of(context).size.height * 0.23,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              '',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
