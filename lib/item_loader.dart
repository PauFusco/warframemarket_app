import 'dart:convert';
import 'package:http/http.dart' as http;

class WarframeItem {
  String itemName;
  String itemDescription;
  String imageURL;

  WarframeItem.fromJson(Map<String, dynamic> json)
      : itemName = json["item"]["items_in_set"][1]["en"]["item_name"],
        itemDescription = json["item"]["items_in_set"][1]["en"]["description"],
        imageURL = "https://warframe.market/static/assets/${json["item"]["items_in_set"][1]["en"]["icon"]}";
}

Future<WarframeItem> loadWarframeItem() async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/wisp_prime_set"),
  );
  final json = jsonDecode(response.body);
  final entireDoc = json["payload"];

  final wfItem = WarframeItem.fromJson(entireDoc);
  return wfItem;
}
