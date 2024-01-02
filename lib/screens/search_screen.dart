import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warframemarket_app/model/item_search_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/warframe_market_logo.png"),
          height: 60,
        ),
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 74, 100, 130),
      ),
      body: Stack(
        children: [
          SarynBackground(),
          const Center(
            child: SizedBox(
              width: 400,
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IamTesting(
              text: (context.watch<List<SearchItemData>?>() == null)
                  ? "Placeholder"
                  : context.watch<List<SearchItemData>>()[0].name)
        ],
      ),
    );
  }
}
