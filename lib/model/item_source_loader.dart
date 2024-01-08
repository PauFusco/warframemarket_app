import 'dart:convert';
import 'package:http/http.dart' as http;

class GenericSource {
  String id, type;
  String? name, sourceImageURL, sourceURL;
  double intact, exceptional, flawless, radiant;

  GenericSource()
      : id = "",
        type = "",
        intact = -1.0,
        exceptional = -1.0,
        flawless = -1.0,
        radiant = -1.0;

  GenericSource.fromJson(Map<String, dynamic> sourceJson)
      : id = sourceJson["relic"],
        type = sourceJson["type"],
        intact = _parseDouble(sourceJson["rates"]["intact"]),
        flawless = _parseDouble(sourceJson["rates"]["flawless"]),
        exceptional = _parseDouble(sourceJson["rates"]["exceptional"]),
        radiant = _parseDouble(sourceJson["rates"]["radiant"]);
}

double _parseDouble(dynamic val) {
  if (val is double) {
    return val;
  } else if (val is int) {
    return val + 0.0;
  } else {
    return -1.0;
  }
}

class RelicSource extends GenericSource {
  @override
  String? name, sourceImageURL, sourceURL;
  GenericSource sourceData;
  bool vaulted;

  RelicSource.fromJson(
      Map<String, dynamic> itemJson, GenericSource sourceDataToLoad)
      : name = itemJson["item_name"],
        sourceImageURL =
            "https://warframe.market/static/assets/${itemJson["thumb"]}",
        sourceURL = itemJson["url_name"],
        sourceData = sourceDataToLoad,
        vaulted = itemJson["vaulted"];
}

class AllSources {
  final List<RelicSource> relics;

  AllSources(
    List<RelicSource> relicList,
  ) : relics = relicList;
}

Future<AllSources> loadAllSources(String itemName) async {
  final dropResponse = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/$itemName/dropsources"),
  );

  final dropJson = jsonDecode(dropResponse.body);
  final jsonDropList = dropJson["payload"]["dropsources"];
  List<GenericSource> sourceList = [];

  for (var jsonSource in jsonDropList) {
    var source = GenericSource.fromJson(jsonSource);
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
    if (source.type == "relic") {
      for (var item in jsonItemList) {
        if (source.id == item["id"]) {
          var relicToAdd = RelicSource.fromJson(item, source);
          relicList.add(relicToAdd);
        }
      }
    }
  }

  var sourcesToReturn = AllSources(relicList);

  return sourcesToReturn;
}
