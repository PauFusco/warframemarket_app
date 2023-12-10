import 'package:flutter/material.dart';

class ValuesBox extends StatelessWidget {
  const ValuesBox({
    super.key,
    required this.masteryLevel,
    required this.tradingTax,
    required this.ducats,
  });

  final int masteryLevel;
  final int tradingTax;
  final int ducats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      decoration: const BoxDecoration(
          color: Color.fromARGB(150, 139, 139, 139),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ValueProperty(propertyName: "Mastery Lvl", value: masteryLevel),
          ValueProperty(propertyName: "Trading Tax", value: tradingTax),
          ValueProperty(propertyName: "Ducats", value: ducats),
        ],
      ),
    );
  }
}

class ValueProperty extends StatelessWidget {
  const ValueProperty({
    super.key,
    required this.propertyName,
    required this.value,
  });

  final String propertyName;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(propertyName,
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 0.9)),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
