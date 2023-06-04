import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/payments_client.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';

class PaymentsRepo {
  PaymentsClient client = PaymentsClient();
  Future<Payment?> createPayment(
      type, accountId, bankId, statement, amount, date) async {
    var createdPayment = await client.createPayment(
        type, accountId, bankId, statement, amount, date);
    print(createdPayment);
    if (createdPayment != null) {
      return Payment.fromMap(jsonDecode(createdPayment));
    }
    return null;
  }
}
