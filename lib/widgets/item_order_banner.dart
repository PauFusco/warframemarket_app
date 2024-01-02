import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_order_loader.dart';

class ItemOrderBanner extends StatelessWidget {
  const ItemOrderBanner({super.key, required this.order});

  final ItemOrder order;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(order.userImageURL),
              opacity: 255.00,
              fit: BoxFit.contain,
            ),
          ),
        )
      ]),
    );
  }
}
