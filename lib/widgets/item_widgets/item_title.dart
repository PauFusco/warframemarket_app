import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    required this.fullSetName,
    required this.itemName,
  });

  final String fullSetName;
  final String itemName;

  @override
  Widget build(BuildContext context) {

    String shortSetName = fullSetName.split(" SET")[0];
    String componentName = itemName.split(shortSetName)[1];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: shortSetName,
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