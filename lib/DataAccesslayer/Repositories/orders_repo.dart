import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/orders_client.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/main.dart';

class OrdersRepo {
  OrdersClient client = OrdersClient();

  Future<List<Order>> getOrders(connected) async {
    var response = await client.getOrders(connected);
    if (response != "") {
      var parsed = response;
      if (connected) {
        parsed = json.decode(response).cast<Map<String, dynamic>>();
      }
      return parsed.map<Order>((json) => Order.fromMap(json)).toList();
    }
    print('1111');
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
      connected,
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
      marketerFee,
      date) async {
    var orderFieldsMap = {
      "total": total,
      "customer_id": customerId,
      "user_id": MyApp.appUser!.id,
      "company_id": MyApp.appUser!.companyId,
      "notes": notes,
      "type": type,
      "paid_up": paidUp,
      "rest_of_the_bill": restOfTheBill,
      "ware_id": wareId,
      "to_ware_id": toWareId,
      "bank_id": bankId,
      "sell_type": sellType,
      "status": status,
      "expenses": expenses,
      "discount": discount,
      "discount_type": discountType,
      "marketer_id": marketerId,
      "marketer_fee_type": marketerFeeType,
      "marketer_fee": marketerFee,
      "details": connected ? details : jsonEncode(details),
      "created_at": date,
      "updated_at": date
    };

    bool isOrderCreated = await client.createOrder(connected, orderFieldsMap);
    return isOrderCreated;
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
      marketerFee,
      date) async {
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
        marketerFee,
        date);
    if (orderUpdationStatus) {
      return true;
    }
    return false;
  }

  Future<Order?> deleteOrder(id) async {
    var deletedOrder = await client.deleteOrder(id);
    if (deletedOrder != null) {
      return Order.fromMap(jsonDecode(deletedOrder));
    }
    return null;
  }
}
