import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_order_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/buy_sell_button.dart';
import 'package:warframemarket_app/widgets/custom_button.dart';
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
          height: 50,
        ),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 74, 100, 130),
      ),
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
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      BuySellButton(
                        text: "SELL",
                        width: screenSize.width / 2,
                        height: 40,
                        active: activeTab == 0,
                        function: () => setActiveItem(0),
                      ),
                      BuySellButton(
                        text: "BUY",
                        width: screenSize.width / 2,
                        height: 40,
                        active: activeTab == 1,
                        function: () => setActiveItem(1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if (activeTab == 0)
                        for (int i = 0; i < dataRequest.sellOrders.length; i++)
                          ItemOrderBanner(
                            order: dataRequest.sellOrders[i],
                            width: screenSize.width,
                            backColor: i % 2.0 == 0.0
                                ? const Color.fromARGB(255, 23, 30, 33)
                                : const Color.fromARGB(255, 16, 22, 25),
                          )
                      else if (activeTab == 1)
                        for (int i = 0; i < dataRequest.buyOrders.length; i++)
                          ItemOrderBanner(
                            order: dataRequest.buyOrders[i],
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
