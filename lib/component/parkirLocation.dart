import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParkirSwipeButton extends StatefulWidget {
  final String nomer;

  const ParkirSwipeButton({
    Key? key,
    required this.nomer,
  }) : super(key: key);

  @override
  State<ParkirSwipeButton> createState() => _ParkirSwipeButtonState();
}

class _ParkirSwipeButtonState extends State<ParkirSwipeButton> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Color.fromRGBO(155, 89, 182, 1),
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      width: MediaQuery.of(context).size.width * 0.438,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(FontAwesomeIcons.locationDot,
                size: 40, color: Color.fromRGBO(155, 89, 182, 1)),
            Text(
              'Parkir ' + widget.nomer,
              style: TextStyle(
                  color: Color.fromRGBO(155, 89, 182, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 27),
            ),
          ],
        ),
      ),
    );
  }
}
