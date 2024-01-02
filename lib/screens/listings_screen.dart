import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_order_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/item_order_banner.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Image(
            image: AssetImage("assets/warframe_market_logo.png"),
            height: 60,
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 74, 100, 130)),
      body: FutureBuilder(
        future: loadOrderList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Stack(
              alignment: Alignment.center,
              children: [
                SarynBackground(),
                CircularProgressIndicator(),
              ],
            );
          }
          final dataRequest = snapshot.data!;
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SarynBackground(),
                Column(
                  children: [
                    for (var itemOrder in dataRequest.orders)
                      ItemOrderBanner(order: itemOrder)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
