import 'package:flutter/material.dart';

class ValuesBox extends StatelessWidget {
  const ValuesBox({
    super.key,
    required this.tradingTax,
    this.masteryLevel,
    this.ducats,
    this.maxRank,
    this.rarity,
  });

  final int tradingTax;
  final int? masteryLevel;
  final int? ducats;
  final int? maxRank;
  final String? rarity;

  @override
  Widget build(BuildContext context) {
    final List<ValueProperty> propertiesList = [];

    propertiesList.add(
      ValueProperty(propertyName: "Trading Tax", value: tradingTax.toString()),
    );
    if (masteryLevel != null) {
      propertiesList.add(
        ValueProperty(
            propertyName: "Mastery Lvl", value: masteryLevel.toString()),
      );
    }
    if (ducats != null) {
      propertiesList.add(
        ValueProperty(propertyName: "Ducats", value: ducats.toString()),
      );
    }
    if (maxRank != null) {
      propertiesList.add(
        ValueProperty(propertyName: "Max Rank", value: maxRank.toString()),
      );
    }
    if (rarity != null) {
      propertiesList.add(
        ValueProperty(
            propertyName: "Rarity",
            value: "${rarity![0].toUpperCase()}${rarity!.substring(1)}"),
      );
    }

    return Container(
      width: 400,
      height: 70,
      decoration: const BoxDecoration(
          color: Color.fromARGB(150, 139, 139, 139),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: propertiesList,
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
  final String value;

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
