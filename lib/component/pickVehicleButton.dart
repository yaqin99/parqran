import 'package:flutter/material.dart';

class PickVehicleButton extends StatelessWidget {
  final String name;
  const PickVehicleButton({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        )
      ],
    );
  }
}
