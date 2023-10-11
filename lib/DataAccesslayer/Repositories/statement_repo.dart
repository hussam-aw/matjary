import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';
import 'package:matjary/main.dart';

class StatementRepo {
  StatementClinet client = StatementClinet();

  Future<List<Statement>> getStatements() async {
    var response = await client.getStatements();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Statement>((json) => Statement.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Statement>> getOfflineStatements() async {
    var response = await client.getOfflineStatementsBasedOnType(['other']);
    if (response != "") {
      var parsed = response;
      return parsed.map<Statement>((json) => Statement.fromMap(json)).toList();
    }
    return [];
  }

  Future<bool> createStatement(
      connected, firstSideId, secondSideId, statement, amount, date) async {
    Map<String, Object?> statementFieldsMap = {};
    if (connected) {
      statementFieldsMap = {
        "first_side_id": firstSideId,
        "second_side_id": secondSideId,
        "user_id": MyApp.appUser!.id,
        'type': 'other',
        "statement": statement,
        "amount": amount,
        "date": date,
      };
    } else {
      statementFieldsMap = {
        "first_side": firstSideId,
        "other_side": secondSideId,
        "user_id": MyApp.appUser!.id,
        'type': 'other',
        "statement": statement,
        "amount": amount,
        "created_at": date,
      };
    }
    var isStatementCreated =
        await client.createStatement(connected, statementFieldsMap);
    return isStatementCreated;
  }
}
