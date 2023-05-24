import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class OrdersClient {
  Future<dynamic> getOrders() async {
    var response = await http.get(Uri.parse("$baseUrl$ordersLink"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createOrder(
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
      marketerFeeType) async {
    var response = await http.post(Uri.parse('$baseUrl$orderLink'),
        body: jsonEncode(<String, dynamic>{
          "total": total,
          "customer_id": customerId,
          "user_id": MyApp.appUser!.id,
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
          "details": details,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateOrder(
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
      marketerFeeType) async {
    var response = await http.post(Uri.parse('$baseUrl$orderLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "total": total,
          "customer_id": customerId,
          "user_id": MyApp.appUser!.id,
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
          "details": details,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteOrder(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$orderLink/$id'));

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
