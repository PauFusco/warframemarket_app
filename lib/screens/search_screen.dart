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
          const SarynBackground(),
          Center(
            child: SizedBox(
              width: 400,
              child: AutoCompTest(
                dataList: context.watch<List<SearchItemData>>(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AutoCompTest extends StatelessWidget {
  const AutoCompTest({
    super.key,
    required this.dataList,
  });

  final List<SearchItemData> dataList;
  static String _displayStringForOption(SearchItemData option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<SearchItemData>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<SearchItemData>.empty();
        }
        return dataList.where((SearchItemData option) {
          return option.name
              .toString()
              .startsWith(textEditingValue.text.toTitleCase());
        });
      },
      onSelected: (SearchItemData selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
        Navigator.pushNamed(context, "/set_details", arguments: selection.url);
      },
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
