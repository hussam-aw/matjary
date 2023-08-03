import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/earns_expenses_client.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';

class EarnsExpensesRepo {
  EarnsExpensesClient client = EarnsExpensesClient();
  Future<List<StatementWithType>> getStatements() async {
    var response = await client.getStatements();

    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<StatementWithType>((json) => StatementWithType.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<bool?> createStatementBsedOnType(
      type, statement, amount, bankId, date) async {
    var createdStatement = await client.createStatementBasedOnType(
        type, statement, amount, bankId, date);
    if (createdStatement != null) {
      return true;
    }
    return null;
  }

  Future<bool?> updateStatement(
      id, type, statement, amount, bankId, date) async {
    var updatedStatement =
        await client.updateStatement(id, type, statement, amount, bankId, date);
    if (updatedStatement != null) {
      return true;
    }
    return null;
  }

  Future<bool?> deleteStatement(id) async {
    var deletedStatement = await client.deleteStatement(id);
    if (deletedStatement != null) {
      return true;
    }
    return null;
  }
}
