import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_order_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/buttons/buy_sell_button.dart';
import 'package:warframemarket_app/widgets/list_widgets/item_order_banner.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int activeTab = 0;

  void setActiveItem(int num) {
    setState(() {
      activeTab = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String? itemToLoad =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 30, 33),
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/warframe_market_logo.png"),
          height: 50,
        ),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 74, 100, 130),
      ),
      body: FutureBuilder(
        future: loadAllOrderLists(itemToLoad!),
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
                        width: screenSize.width / 2.0,
                        height: 40,
                        active: activeTab == 0,
                        function: () => setActiveItem(0),
                      ),
                      BuySellButton(
                        text: "BUY",
                        width: screenSize.width / 2.0,
                        height: 40,
                        active: activeTab == 1,
                        function: () => setActiveItem(1),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 28, 32, 34),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 11, 13, 14),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              right: 25,
                            ),
                            child: const Text(
                              "QUANTITY",
                              style: TextStyle(
                                color: Color.fromARGB(255, 92, 97, 99),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              right: 25,
                            ),
                            child: const Text(
                              "PRICE",
                              style: TextStyle(
                                color: Color.fromARGB(255, 92, 97, 99),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      )
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
