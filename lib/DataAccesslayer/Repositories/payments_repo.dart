import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/main.dart';

class PaymentsRepo {
  StatementClinet client = StatementClinet();

  Future<List<Payment>> getPayments() async {
    var response = await client.getPayments();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Payment>((json) => Payment.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Payment>> getOfflinePayments() async {
    var response =
        await client.getOfflineStatementsBasedOnType(['payment', 'income']);
    if (response != "") {
      var parsed = response;
      return parsed
          .map<Payment>((json) => Payment.fromDatabaseMap(json))
          .toList();
    }
    return [];
  }

  Future<bool> createPayment(
      connected, type, accountId, bankId, statement, amount, date) async {
    Map<String, Object?> statementFieldsMap = {};
    if (connected) {
      statementFieldsMap = {
        "type": type,
        "account_id": accountId,
        "bank_id": bankId,
        "amount": amount,
        "statement": statement,
        "date": date,
        "user_id": MyApp.appUser!.id,
      };
    } else {
      statementFieldsMap = {
        "type": type,
        "first_side": accountId,
        "other_side": bankId,
        "amount": amount,
        "statement": statement,
        "created_at": date,
        "user_id": MyApp.appUser!.id,
      };
    }
    var isCreatedStatement =
        await client.createStatement(connected, statementFieldsMap);
    return isCreatedStatement;
  }

  Future<bool> updatePayment(
      id, type, accountId, bankId, statement, amount, date) async {
    var statementFieldsMap = {
      "type": type,
      "account_id": accountId,
      "bank_id": bankId,
      "amount": amount,
      "statement": statement,
      "date": date,
      "user_id": MyApp.appUser!.id,
    };
    var isPaymentUpdated = await client.updateStatement(id, statementFieldsMap);
    return isPaymentUpdated;
  }

  Future<bool> deletePayment(id) async {
    var isPaymentDeleted = await client.deleteStatement(id);
    return isPaymentDeleted;
  }
}
