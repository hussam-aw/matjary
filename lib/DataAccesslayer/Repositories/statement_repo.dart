import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';

class StatementRepo {
  StatementClinet client = StatementClinet();

  Future<Statement?> createStatement(
      firstSideId, secondSideId, userId, statement, amount, date) async {
    var createdStatement = await client.createStatement(
        firstSideId, secondSideId, userId, statement, amount, date);
    print(createdStatement);
    if (createdStatement != null) {
      return Statement.fromMap(jsonDecode(createdStatement));
    }
    return null;
  }
}
