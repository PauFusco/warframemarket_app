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
      height: 70,
      width: width,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(order.userImageURL),
                opacity: 255.00,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.userName,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 48, 105, 121),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 48, 105, 121),
                  ),
                ),
                Text(
                  order.userStatus,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 137, 149, 153),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
