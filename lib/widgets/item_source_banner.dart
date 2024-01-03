import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_source_loader.dart';

class ItemSourceBanner extends StatelessWidget {
  const ItemSourceBanner({
    super.key,
    required this.relic,
  });

  final RelicSource relic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 200,
        color: const Color.fromARGB(255, 16, 22, 25),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(relic.itemImageURL),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(
                    relic.relicName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 60, 135, 156),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 60, 135, 156),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
