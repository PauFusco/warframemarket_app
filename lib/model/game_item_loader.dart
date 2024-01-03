import 'dart:convert';
import 'package:http/http.dart' as http;

class GameItem {
  String itemName;
  String itemDescription;
  String imageURL;
  int tradingTax;
  int maxRank;
  String rarity;

  GameItem()
      : itemName = "ItemNotFound",
        itemDescription = "NoDescription",
        imageURL = (""),
        tradingTax = -1,
        maxRank = -1,
        rarity = "NoRarity";
  GameItem.fromJson(Map<String, dynamic> itemJson)
      : itemName = itemJson["en"]["item_name"],
        itemDescription = itemJson["en"]["description"],
        imageURL = (!itemJson["en"]["item_name"].contains("Set")
            ? "https://warframe.market/static/assets/${itemJson["sub_icon"]}"
            : "https://warframe.market/static/assets/${itemJson["icon"]}"),
        tradingTax = itemJson["trading_tax"],
        maxRank = itemJson["mod_max_rank"],
        rarity = itemJson["rarity"];
}

Future<GameItem> loadGameItem(String itemName) async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/${itemName}"),
  );
  final json = jsonDecode(response.body);

  var jsonItemsList = json["payload"]["item"]["items_in_set"];

  return GameItem.fromJson(jsonItemsList);
}
