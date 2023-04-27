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

  Future<Order?> createOrder(id, total, notes, type, paidUp, restOfTheBill,
      wareId, toWareId, bankId, sellType, status, expenses, discount) async {
    var createdOrder = await client.createOrder(
        id,
        total,
        notes,
        type,
        paidUp,
        restOfTheBill,
        wareId,
        toWareId,
        bankId,
        sellType,
        status,
        expenses,
        discount);
    print(createdOrder);
    if (createdOrder != null) {
      return Order.fromMap(jsonDecode(createdOrder));
    }
    return null;
  }

  Future<Order?> updateOrder(id, total, notes, type, paidUp, restOfTheBill,
      wareId, toWareId, bankId, sellType, status, expenses, discount) async {
    var updateOrder = await client.updateOrder(
        id,
        total,
        notes,
        type,
        paidUp,
        restOfTheBill,
        wareId,
        toWareId,
        bankId,
        sellType,
        status,
        expenses,
        discount);
    print(updateOrder);
    if (updateOrder != null) {
      return Order.fromMap(jsonDecode(updateOrder));
    }
    return null;
  }

  Future<Order?> deleteOrder(id) async {
    var deletedOrder = await client.deleteOrder(id);
    print(deletedOrder);
    if (deletedOrder != null) {
      return Order.fromMap(jsonDecode(deletedOrder));
    }
    return null;
  }
}
