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

  Future<List<Order>> getOrdersLastDay() async {
    var response = await client.getOrdersLastDay();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Order>> getOrdersLastWeek() async {
    var response = await client.getOrdersLastWeek();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Order>> getOrdersLastMonth() async {
    var response = await client.getOrdersLastMonth();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromMap(json)).toList();
    }
    return [];
  }

  Future<bool> createOrder(
      customerId,
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
      discount,
      marketerId,
      discountType,
      details,
      marketerFeeType,
      marketerFee) async {
    var orderCreationStatus = await client.createOrder(
        customerId,
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
        discount,
        marketerId,
        discountType,
        details,
        marketerFeeType,
        marketerFee);

    if (orderCreationStatus) {
      return true;
    }
    return false;
  }

  Future<bool> updateOrder(
      id,
      customerId,
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
      discount,
      marketerId,
      discountType,
      details,
      marketerFeeType,
      marketerFee) async {
    var orderUpdationStatus = await client.updateOrder(
        id,
        customerId,
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
        discount,
        marketerId,
        discountType,
        details,
        marketerFeeType,
        marketerFee);
    if (orderUpdationStatus) {
      return true;
    }
    return false;
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
