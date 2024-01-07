import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warframemarket_app/model/item_search_loader.dart';
import 'package:warframemarket_app/widgets/autocomp_search.dart';
import 'package:warframemarket_app/widgets/background.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AutoCompSearch searchAutoComplete = AutoCompSearch(
      dataList: context.watch<List<SearchItemData>>(),
    );

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
          const SarynBackground(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  child: searchAutoComplete,
                ),
                GestureDetector(
                  onTap: () {
                    if (searchAutoComplete.currentFirstOption != null) {
                      Navigator.pushNamed(context, "/set_details",
                          arguments:
                              searchAutoComplete.currentFirstOption!.url);
                    }
                  },
                  child: Container(
                    width: 65,
                    height: 56,
                    color: const Color.fromARGB(255, 60, 135, 156),
                    child: const Icon(Icons.search),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
