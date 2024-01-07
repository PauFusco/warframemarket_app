import 'package:flutter/material.dart';

class ItemDescriptionBox extends StatelessWidget {
  const ItemDescriptionBox({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.grey.shade700, width: 6),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Center(
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}