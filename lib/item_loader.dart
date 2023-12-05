import 'dart:convert';
import 'package:http/http.dart' as http;

class WarframeItem {
  String itemName;
  String itemDescription;
  String imageURL;

  WarframeItem.fromJson(Map<String, dynamic> itemJson)
      : itemName = itemJson["en"]["item_name"],
        itemDescription = itemJson["en"]["description"],
        imageURL = (!itemJson["en"]["item_name"].contains("Set")
            ? "https://warframe.market/static/assets/${itemJson["sub_icon"]}"
            : "https://warframe.market/static/assets/${itemJson["icon"]}");
}

//Not needed right now
/*
Future<WarframeItem> loadWarframeItem() async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/wisp_prime_set"),
  );
  final json = jsonDecode(response.body);
  final entireDoc = json["payload"];

  final wfItem = WarframeItem.fromJson(entireDoc);
  return wfItem;
}
*/

class WarframeSetData {
  WarframeItem set;
  WarframeItem blueprint;
  WarframeItem neuroptics;
  WarframeItem chassis;
  WarframeItem systems;

  WarframeSetData(
      this.set, this.blueprint, this.neuroptics, this.chassis, this.systems);
}

Future<WarframeSetData> loadWarframeSet(String setName) async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/${setName}_set"),
  );
  final json = jsonDecode(response.body);

  //This is hardcoded to work for Wisp Prime
  final WarframeItem chassis =
      WarframeItem.fromJson(json["payload"]["item"]["items_in_set"][0]);
  final WarframeItem set =
      WarframeItem.fromJson(json["payload"]["item"]["items_in_set"][1]);
  final WarframeItem neuroptics =
      WarframeItem.fromJson(json["payload"]["item"]["items_in_set"][2]);
  final WarframeItem systems =
      WarframeItem.fromJson(json["payload"]["item"]["items_in_set"][3]);
  final WarframeItem blueprint =
      WarframeItem.fromJson(json["payload"]["item"]["items_in_set"][4]);

  WarframeSetData setData =
      WarframeSetData(set, blueprint, neuroptics, chassis, systems);

  return setData;
}
