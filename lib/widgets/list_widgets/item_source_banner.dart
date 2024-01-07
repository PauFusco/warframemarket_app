import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_source_loader.dart';

class ItemSourceBanner extends StatelessWidget {
  const ItemSourceBanner({
    super.key,
    required this.source,
  });

  final RelicSource source;

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
                  image: NetworkImage(source.sourceImageURL!),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  source.name!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 60, 135, 156),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 60, 135, 156),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Intact: ${source.sourceData.intact.toString()}%",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 135, 139, 140),
                            ),
                          ),
                          Text(
                            "Flawless: ${source.sourceData.flawless.toString()}%",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 135, 139, 140),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exceptional: ${source.sourceData.exceptional.toString()}%",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 135, 139, 140),
                            ),
                          ),
                          Text(
                            "Radiant: ${source.sourceData.radiant.toString()}%",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 135, 139, 140),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                source.vaulted
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 54, 49, 29),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: const Text(
                          "  Vaulted  ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 150, 2),
                            fontSize: 13,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 25,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
