import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/payments_client.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';

class PaymentsRepo {
  PaymentsClient client = PaymentsClient();
  Future<List<Payment>> getPayments() async {
    var response = await client.getPayments();

    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Payment>((json) => Payment.fromMap(json)).toList();
    }
    return [];
  }
}
