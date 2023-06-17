import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class OrdersClient {
  Future<dynamic> getOrders() async {
    var response =
        await http.get(Uri.parse("$baseUrl$ordersLink/${MyApp.appUser!.id}"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getOrdersLastDay() async {
    var response = await http.get(Uri.parse("$baseUrl$ordersLastDayLink"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getOrdersLastWeek() async {
    var response = await http.get(Uri.parse("$baseUrl$ordersLastWeekLink"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getOrdersLastMonth() async {
    var response = await http.get(Uri.parse("$baseUrl$ordersLastMonthLink"));
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
      marketerFeeType,
      marketerFee,
      date) async {
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
          "marketer_fee": marketerFee,
          "details": details,
          "created_at": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.body);
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
      marketerFeeType,
      marketerFee,
      date) async {
    print(date);
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
          "marketer_fee": marketerFee,
          "details": details,
          "updated_at": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
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
