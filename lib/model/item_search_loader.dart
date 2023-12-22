import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchItemData {
  String name, url, thumbnail;

  SearchItemData.fromJson(Map<String, dynamic> itemJson)
      : name = itemJson["item_name"],
        url = itemJson["url_name"],
        thumbnail = itemJson["thumb"];
}

Future<List<SearchItemData>> loadItemsFromFile() async {
  final jsonList = await rootBundle.loadString("assets/itemlist.json");
  final jsonDecoded = jsonDecode(jsonList.toString());

  List<SearchItemData> itemsList = [];

  for (final item in jsonDecoded["payload"]["items"]) {
    itemsList.add(SearchItemData.fromJson(item));
  }

  return itemsList;
}

class IamTesting
 extends StatelessWidget {
  const IamTesting
  ({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
