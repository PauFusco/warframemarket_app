import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemOrder {
  int quantity;
  int price;
  String orderType;
  String userName;
  String userImageURL;
  String userRegion;
  String userStatus;

  ItemOrder()
      : quantity = -1,
        price = -1,
        orderType = "",
        userName = "UserNotFound",
        userImageURL = "UserNotFound",
        userRegion = "UserRegionNotFound",
        userStatus = "UserStatusNotFound";

  ItemOrder.fromJson(Map<String, dynamic> orderJson)
      : quantity = orderJson["quantity"],
        price = orderJson["platinum"],
        orderType = orderJson["order_type"],
        userName = orderJson["user"]["ingame_name"],
        userImageURL = orderJson["user"]["avatar"] != null
            ? "https://warframe.market/static/assets/${orderJson["user"]["avatar"]}"
            : "https://warframe.market/static/assets/user/default-avatar.png",
        userRegion = orderJson["user"]["region"],
        userStatus = orderJson["user"]["status"];
}

class AllOrdersLists {
  List<ItemOrder> buyOrders;
  List<ItemOrder> sellOrders;

  AllOrdersLists(this.buyOrders, this.sellOrders);
}

Future<AllOrdersLists> loadAllOrderLists(String itemName) async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/$itemName/orders"),
  );

  final json = jsonDecode(response.body);
  final jsonOrderList = json["payload"]["orders"];
  List<ItemOrder> buyOrdersToAdd = [];
  List<ItemOrder> sellOrdersToAdd = [];

  for (var jsonOrder in jsonOrderList) {
    var order = ItemOrder.fromJson(jsonOrder);
    order.orderType == "buy"
        ? buyOrdersToAdd.add(order)
        : sellOrdersToAdd.add(order);
  }

  buyOrdersToAdd.sort(compareStatus);
  sellOrdersToAdd.sort(compareStatus);

  return AllOrdersLists(buyOrdersToAdd, sellOrdersToAdd);
}

// Custom comparator function
int compareStatus(ItemOrder a, ItemOrder b) {
  // Define the order of statuses
  Map<String, int> statusOrder = {
    "ingame": 0,
    "online": 1,
    "offline": 2,
  };
  return statusOrder[a.userStatus]!.compareTo(statusOrder[b.userStatus]!);
}
