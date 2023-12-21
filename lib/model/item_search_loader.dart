import 'dart:convert';

import 'package:flutter/services.dart';

class SearchItemData {
  String name, url, thumbnail;

  SearchItemData.fromJson(Map<String, dynamic> itemJson)
      : name = itemJson["item_name"],
        url = itemJson["url_name"],
        thumbnail = itemJson["thumb"];
}

Future<SearchItemData> loadItemsFromFile() {
  final jsonList = rootBundle.loadString("assets/itemlist.json");
  final jsonDecoded = jsonDecode(jsonList.toString());

  return SearchItemData.fromJson(jsonDecoded["payload"]["items"][0]);
}
