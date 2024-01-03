import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelicSource {
  String relicName;
  Source sourceData;

  RelicSource.fromJson(Map<String, dynamic> itemJson, Source dropDataToGet)
      : relicName = itemJson["item_name"],
        sourceData = dropDataToGet;
}

class Source {
  String id;
  int intact, exceptional, flawless, radiant;

  Source()
      : id = "",
        intact = -1,
        exceptional = -1,
        flawless = -1,
        radiant = -1;

  Source.fromJson(Map<String, dynamic> sourceJson)
      : id = sourceJson["relic"],
        intact = sourceJson["rates"]["intact"],
        exceptional = sourceJson["rates"]["exceptional"],
        flawless = sourceJson["rates"]["flawless"],
        radiant = sourceJson["rates"]["radiant"];
}

Future<List<RelicSource>> loadAllRelicSources(String itemName) async {
  final dropResponse = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/$itemName/dropsources"),
  );

  final dropJson = jsonDecode(dropResponse.body);
  final jsonDropList = dropJson["payload"]["dropsources"];
  List<Source> sourceList = [];

  for (var jsonSource in jsonDropList) {
    var source = Source.fromJson(jsonSource);
    var audit = source;
    sourceList.add(audit);
  }

  final itemResponse = await http.get(
    Uri.parse("https://api.warframe.market/v1/items"),
  );

  final itemJson = jsonDecode(itemResponse.body);
  final jsonItemList = itemJson["payload"]["items"];
  List<RelicSource> relicList = [];

  for (var source in sourceList) {
    for (var item in jsonItemList) {
      if (source.id == item["id"]) {
        var relicToAdd = RelicSource.fromJson(item, source);
        relicList.add(relicToAdd);
      }
    }
  }

  return relicList;
}
