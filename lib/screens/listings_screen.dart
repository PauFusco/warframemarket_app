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
  int activeTab = 0;

  void setActiveItem(int num) {
    setState(() {
      activeTab = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String? setToLoad =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
          title: const Image(
            image: AssetImage("assets/warframe_market_logo.png"),
            height: 60,
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 74, 100, 130)),
      body: FutureBuilder(
        future: loadAllOrderLists(
          setToLoad!.toLowerCase().replaceAll(" ", "_"),
        ),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < dataRequest.sellOrders.length; i++)
                        if (dataRequest.sellOrders[i].visible)
                          ItemOrderBanner(
                            order: dataRequest.sellOrders[i],
                            width: screenSize.width,
                            backColor: i % 2.0 == 0.0
                                ? const Color.fromARGB(255, 23, 30, 33)
                                : const Color.fromARGB(255, 16, 22, 25),
                          )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
