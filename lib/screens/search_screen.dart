import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warframemarket_app/model/item_search_loader.dart';
import 'package:warframemarket_app/string_extension.dart';
import 'package:warframemarket_app/widgets/background.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AutoCompTest searchAutoComplete = AutoCompTest(
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

class AutoCompTest extends StatefulWidget {
  AutoCompTest({
    super.key,
    required this.dataList,
  });

  final List<SearchItemData> dataList;
  static String _displayStringForOption(SearchItemData option) => option.name;
  SearchItemData? currentFirstOption;

  @override
  State<AutoCompTest> createState() => _AutoCompTestState();
}

class _AutoCompTestState extends State<AutoCompTest> {
  void _updateCurrentFirstOption(SearchItemData? firstOption) {
    widget.currentFirstOption = firstOption;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<SearchItemData>(
      displayStringForOption: AutoCompTest._displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          setState(() {
            _updateCurrentFirstOption(null);
          });
          return const Iterable<SearchItemData>.empty();
        }
        return widget.dataList.where((SearchItemData option) {
          return option.name
              .toString()
              .startsWith(textEditingValue.text.toTitleCase());
        });
      },
      onSelected: (SearchItemData selection) {
        _updateCurrentFirstOption(selection);
        Navigator.pushNamed(context, "/set_details", arguments: selection.url);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.addListener(() {
          setState(() {
            _updateCurrentFirstOption(widget.currentFirstOption);
          });
        });
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 18, 18, 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 7, 16, 19),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 27, 177, 148),
                width: 2,
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          cursorHeight: 22,
          cursorWidth: 1,
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<SearchItemData> onSelected,
          Iterable<SearchItemData> options) {
        _updateCurrentFirstOption(options.first);
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: (options.length > 3) ? 192 : options.length * 48, maxWidth: 400),
              color: const Color.fromARGB(255, 23, 30, 33),
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index).name;
                  return ListTile(
                    title: Text(option, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      onSelected(options.elementAt(index));
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
