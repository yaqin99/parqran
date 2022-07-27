import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'person.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Selamat Datang ${person.name}',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(52, 152, 219, 1)),
      ),
    );
  }
}
