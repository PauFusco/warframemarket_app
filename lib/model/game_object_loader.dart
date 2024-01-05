import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> loadGameObject(String objectName) async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/$objectName"),
  );
  final json = jsonDecode(response.body);

  var jsonItemsList = json["payload"]["item"]["items_in_set"];

  if (jsonItemsList.length > 1) {
    SetItem? setToAdd;
    List<SetItem> componentsToAdd = [];

    for (var component in jsonItemsList) {
      if (component["url_name"].toString().contains("_set")) {
        setToAdd = SetItem.fromJson(component);
      } else if (component != null) {
        componentsToAdd.add(SetItem.fromJson(component));
      } else {
        componentsToAdd.add(SetItem());
      }
    }

    setToAdd ??= SetItem();

    return GenericSetData(setToAdd, componentsToAdd);
  } else {
    return GameItem.fromJson(jsonItemsList.single);
  }
}

class SetItem {
  String itemName;
  String itemDescription;
  String imageURL;
  String itemURL;
  String? wikiLink;
  int tradingTax;
  int? masteryLevel;
  int? ducats;

  SetItem()
      : itemName = "ItemNotFound",
        itemDescription = "NoDescription",
        imageURL = "",
        itemURL = "",
        wikiLink = "https://warframe.fandom.com/wiki/WARFRAME_Wiki",
        tradingTax = -1,
        masteryLevel = -1,
        ducats = -1;
  SetItem.fromJson(Map<String, dynamic> itemJson)
      : itemName = itemJson["en"]["item_name"],
        itemDescription = itemJson["en"]["description"],
        imageURL = (!itemJson["en"]["item_name"].contains("Set")
            ? "https://warframe.market/static/assets/${itemJson["sub_icon"]}"
            : "https://warframe.market/static/assets/${itemJson["icon"]}"),
        itemURL = itemJson["url_name"],
        wikiLink = itemJson["en"]["wiki_link"],
        tradingTax = itemJson["trading_tax"],
        masteryLevel = itemJson["mastery_level"],
        ducats = itemJson["ducats"];
}

class GenericSetData {
  SetItem set;
  List<SetItem> components;

  GenericSetData(this.set, this.components);
}

class GameItem {
  String itemName;
  String itemDescription;
  String imageURL;
  String itemURL;
  String? wikiLink;
  int tradingTax;
  int? maxRank;
  String? rarity;

  GameItem()
      : itemName = "ItemNotFound",
        itemDescription = "NoDescription",
        imageURL = "",
        itemURL = "",
        wikiLink = "https://warframe.fandom.com/wiki/WARFRAME_Wiki",
        tradingTax = -1,
        maxRank = -1,
        rarity = "NoRarity";
  GameItem.fromJson(Map<String, dynamic> itemJson)
      : itemName = itemJson["en"]["item_name"],
        itemDescription = itemJson["en"]["description"],
        imageURL = "https://warframe.market/static/assets/${itemJson["icon"]}",
        itemURL = itemJson["url_name"],
        wikiLink = itemJson["en"]["wiki_link"],
        tradingTax = itemJson["trading_tax"],
        maxRank = itemJson["mod_max_rank"],
        rarity = itemJson["rarity"];
}
