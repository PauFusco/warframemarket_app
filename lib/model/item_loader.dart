import 'dart:convert';
import 'package:http/http.dart' as http;

class WarframeItem {
  String itemName;
  String itemDescription;
  String imageURL;
  int masteryLevel;
  int tradingTax;
  int ducats;

  WarframeItem()
      : itemName = "ItemNotFound",
        itemDescription = "NoDescription",
        imageURL = (""),
        masteryLevel = -1,
        tradingTax = -1,
        ducats = -1;
  WarframeItem.fromJson(Map<String, dynamic> itemJson)
      : itemName = itemJson["en"]["item_name"],
        itemDescription = itemJson["en"]["description"],
        imageURL = (!itemJson["en"]["item_name"].contains("Set")
            ? "https://warframe.market/static/assets/${itemJson["sub_icon"]}"
            : "https://warframe.market/static/assets/${itemJson["icon"]}"),
        masteryLevel = itemJson["mastery_level"],
        tradingTax = itemJson["trading_tax"],
        ducats = itemJson["ducats"];
}

class GenericSetData {
  WarframeItem set;
  List<WarframeItem> components;

  GenericSetData(this.set, this.components);
}

Future<GenericSetData> loadGenericSet(String setName) async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/${setName}_set"),
  );
  final json = jsonDecode(response.body);

  var jsonItemsList = json["payload"]["item"]["items_in_set"];

  WarframeItem? setToAdd;
  List<WarframeItem> componentsToAdd = [];

  for (var component in jsonItemsList) {
    if (component["url_name"].toString().contains("prime_set")) {
      setToAdd = WarframeItem.fromJson(component);
    } else if (component != null) {
      componentsToAdd.add(WarframeItem.fromJson(component));
    } else {
      componentsToAdd.add(WarframeItem());
    }
  }
  setToAdd ??= WarframeItem();

  return GenericSetData(setToAdd, componentsToAdd);
}
