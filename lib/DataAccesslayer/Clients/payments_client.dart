import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class PaymentsClient {
  Future<dynamic> getPayments() async {
    var response =
        await http.get(Uri.parse("$baseUrl$paymentsLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createPayment(
      type, accountId, bankId, statement, amount, date) async {
    var response = await http.post(Uri.parse('$baseUrl$statementLink'),
        body: jsonEncode(<String, dynamic>{
          "type": type,
          "account_id": accountId,
          "bank_id": bankId,
          "amount": amount,
          "statement": statement,
          "date": date,
          "user_id": MyApp.appUser!.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      return true;
    } else {
      return null;
    }
  }
}
