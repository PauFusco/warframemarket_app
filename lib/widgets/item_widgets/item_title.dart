import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    required this.itemName,
  });

  final String itemName;

  @override
  Widget build(BuildContext context) {
    final splitted = itemName.split("PRIME");

    String setName = "${splitted[0]}PRIME";
    String componentName = splitted[1];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: setName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: componentName,
            style: const TextStyle(
              color: Color.fromARGB(255, 27, 147, 178),
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}