import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/main.dart';

class EarnsExpensesRepo {
  StatementClinet client = StatementClinet();

  Future<List<StatementWithType>> getEarnsAndExpenses() async {
    var response = await client.getEarnsAndExpenses();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<StatementWithType>((json) => StatementWithType.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<List<StatementWithType>> getOfflineEarnsAndExpenses() async {
    var response =
        await client.getOfflineStatementsBasedOnType(['revenues', 'expenses']);
    if (response != "") {
      var parsed = response;
      return parsed
          .map<StatementWithType>(
              (json) => StatementWithType.fromDatabaseMap(json))
          .toList();
    }
    return [];
  }

  Future<bool> createStatementBsedOnType(
      connected, type, statement, amount, bankId, date) async {
    Map<String, Object?> statementFieldsMap = {};
    if (connected) {
      statementFieldsMap = {
        "type": type,
        "statement": statement,
        "amount": amount,
        "bank_id": bankId,
        "date": date,
        "user_id": MyApp.appUser!.companyId,
      };
    } else {
      statementFieldsMap = {
        "type": type,
        "statement": statement,
        "amount": amount,
        "other_side": bankId,
        "created_at": date,
        "user_id": MyApp.appUser!.companyId,
      };
    }
    var isCreatedStatement =
        await client.createStatement(connected, statementFieldsMap);
    return isCreatedStatement;
  }

  Future<bool?> updateStatement(
      id, type, statement, amount, bankId, date) async {
    var statementFieldMap = {
      "type": type,
      "statement": statement,
      "amount": amount,
      "bank_id": bankId,
      "date": date,
      "user_id": MyApp.appUser!.companyId,
    };
    var isUpdatedStatement =
        await client.updateStatement(id, statementFieldMap);
    return isUpdatedStatement;
  }

  Future<bool> deleteStatement(id) async {
    var deletedStatement = await client.deleteStatement(id);
    if (deletedStatement != null) {
      return true;
    }
    return false;
  }
}
