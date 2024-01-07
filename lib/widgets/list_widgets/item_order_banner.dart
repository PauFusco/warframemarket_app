import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_order_loader.dart';

class ItemOrderBanner extends StatelessWidget {
  const ItemOrderBanner({
    super.key,
    required this.order,
    required this.width,
    required this.backColor,
  });

  final ItemOrder order;
  final double width;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backColor,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(order.userImageURL),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.userName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 48, 105, 121),
                      decorationColor: Color.fromARGB(255, 48, 105, 121),
                    ),
                  ),
                  Text(
                    order.userStatus,
                    style: TextStyle(
                      color: (order.userStatus == "ingame")
                          ? const Color.fromARGB(255, 147, 112, 219)
                          : (order.userStatus == "online")
                              ? const Color.fromARGB(255, 0, 100, 0)
                              : const Color.fromARGB(255, 139, 0, 0),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  child: Text(
                    order.quantity.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 113, 118, 118),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 90,
                  child: Text(
                    order.price.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 193, 71, 151),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
