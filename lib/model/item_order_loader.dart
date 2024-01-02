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
  String userImageURL;
  String userRegion;
  String userStatus;

  ItemOrder()
      : quantity = -1,
        price = -1,
        orderType = OrderType.sell,
        orderVisibility = OrderVisibility.invisible,
        userName = "UserNotFound",
        userImageURL = "UserNotFound",
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
        userImageURL = orderJson["user"]["avatar"] != null
            ? "https://warframe.market/static/assets/${orderJson["user"]["avatar"]}"
            : "https://t4.ftcdn.net/jpg/02/20/23/75/360_F_220237587_kxc7veNNrvvzwcPjSf9yZHzzMiE2ER0p.jpg",
        userRegion = orderJson["user"]["region"],
        userStatus = orderJson["user"]["status"];
}

class OrderList {
  List<ItemOrder> orders;

  OrderList(this.orders);
}

Future<OrderList> loadOrderList() async {
  final response = await http.get(
    Uri.parse("https://api.warframe.market/v1/items/wisp_prime_set/orders"),
  );

  final json = jsonDecode(response.body);
  final jsonOrderList = json["payload"]["orders"];
  List<ItemOrder> ordersToAdd = [];

  for (var jsonOrder in jsonOrderList) {
    var order = ItemOrder.fromJson(jsonOrder);
    ordersToAdd.add(order);
  }

  return OrderList(ordersToAdd);
}
