import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class PaymentsClient {
  Future<dynamic> createPayment(
      type, accountId, bankId, statement, amount, date) async {
    var response = await http.post(Uri.parse('$baseUrl$paymentLink'),
        body: jsonEncode(<String, dynamic>{
          "type": type,
          "account_id": accountId,
          "bank_id": bankId,
          "amount": amount,
          "statement": statement,
          "created_at": date,
          "user_id": MyApp.appUser!.id,
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
}
