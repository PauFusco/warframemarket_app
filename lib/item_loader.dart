import 'dart:convert';
import 'package:http/http.dart' as http;

class WarframeItem {
  String itemName;
  String itemDescription;

  WarframeItem.fromJson(Map<String, dynamic> json)
      : itemName = json["item"]["items_in_set"][0]["en"]["item_name"],
        itemDescription = json["item"]["items_in_set"][0]["en"]["description"];
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
