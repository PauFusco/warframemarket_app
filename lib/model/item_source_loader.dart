import 'dart:convert';
import 'package:http/http.dart' as http;

class GenericSource {
  String id, type;
  int? rate;
  int? intact, exceptional, flawless, radiant;

  GenericSource()
      : id = "",
        type = "";

  GenericSource.fromJson(Map<String, dynamic> sourceJson)
      : id = sourceJson["relic"],
        type = sourceJson["type"];
}

class RelicSource extends GenericSource {
  String relicName, itemImageURL;
  RelicSource.fromJson(Map<String, dynamic> itemJson)
      : relicName = itemJson["item_name"],
        itemImageURL =
            "https://warframe.market/static/assets/${itemJson["thumb"]}";
}

class MissionSource extends GenericSource {
  String missionName, missionImageURL;

  MissionSource.fromJson(Map<String, dynamic> missionJson)
      : missionName = missionJson["name"],
        missionImageURL =
            "https://warframe.market/static/assets/${missionJson["thumb"]}";
}

class NPCSource extends GenericSource {
  String npcName, npcImageURL;

  NPCSource.fromJson(Map<String, dynamic> npcJson)
      : npcName = npcJson["name"],
        npcImageURL =
            "https://warframe.market/static/assets/${npcJson["thumb"]}";
}

class AllSources {
  final List<RelicSource> relics;
  final List<MissionSource> missions;
  final List<NPCSource> npcs;

  AllSources(
    List<MissionSource> missionList,
    List<RelicSource> relicList,
    List<NPCSource> npcList,
  )   : missions = missionList,
        relics = relicList,
        npcs = npcList;
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
  final missionResponse = await http.get(
    Uri.parse("https://api.warframe.market/v1/missions"),
  );
  final npcResponse = await http.get(
    Uri.parse("https://api.warframe.market/v1/npc"),
  );

  final itemJson = jsonDecode(itemResponse.body);
  final jsonItemList = itemJson["payload"]["items"];
  List<RelicSource> relicList = [];

  final missionJson = jsonDecode(missionResponse.body);
  final jsonMissionList = missionJson["payload"]["missions"];
  List<MissionSource> missionList = [];

  final npcJson = jsonDecode(npcResponse.body);
  final jsonNPCList = npcJson["payload"]["npc"];
  List<NPCSource> npcList = [];

  for (var source in sourceList) {
    if (source.type == "relic") {
      for (var item in jsonItemList) {
        if (source.id == item["id"]) {
          var relicToAdd = RelicSource.fromJson(item);
          relicList.add(relicToAdd);
        }
      }
    }
    if (source.type == "mission") {
      for (var mission in jsonMissionList) {
        if (source.id == mission["id"]) {
          var missionToAdd = MissionSource.fromJson(mission);
          missionList.add(missionToAdd);
        }
      }
    }
    if (source.type == "npc") {
      for (var npc in jsonNPCList) {
        if (source.id == npc["id"]) {
          var npcToAdd = NPCSource.fromJson(npc);
          npcList.add(npcToAdd);
        }
      }
    }
  }

  var sourcesToReturn = AllSources(missionList, relicList, npcList);

  return sourcesToReturn;
}
