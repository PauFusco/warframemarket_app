import 'dart:convert';
import 'package:http/http.dart' as http;

enum OrderType { sell, buy }

enum OrderVisibility { visible, invisible }

class ItemOrder {
  int quantity;
  int price;
  OrderType orderType;
  OrderVisibility orderVisibility;
  String userName;
  String userRegion;
  String userStatus;

  ItemOrder()
      : quantity = -1,
        price = -1,
        orderType = OrderType.sell,
        orderVisibility = OrderVisibility.invisible,
        userName = "UserNotFound",
        userRegion = "UserRegionNotFound",
        userStatus = "UserStatusNotFound";

  ItemOrder.fromJson(Map<String, dynamic> orderJson)
      : quantity = orderJson["quantity"],
        price = orderJson["platinum"],
        orderType =
            orderJson["order_type"] == "sell" ? OrderType.sell : OrderType.buy,
        orderVisibility = orderJson["visible"] == "true"
            ? OrderVisibility.visible
            : OrderVisibility.invisible,
        userName = orderJson["user"]["ingame_name"],
        userRegion = orderJson["user"]["region"],
        userStatus = orderJson["user"]["status"];
}

Future<ItemOrder> loadGenericOrder() async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/wisp_prime_set/orders"),
  );

  final json = jsonDecode(response.body);

  return ItemOrder.fromJson(json["payload"]["orders"][0]);
}
