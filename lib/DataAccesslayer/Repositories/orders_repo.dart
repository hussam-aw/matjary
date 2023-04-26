import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/orders_client.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';

class OrdersRepo {
  OrdersClient client = OrdersClient();
  Future<List<Order>> getOrders() async {
    var response = await client.getOrders();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromMap(json)).toList();
    }
    return [];
  }
}
