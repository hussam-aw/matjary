import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';
import 'package:matjary/main.dart';

class StatementRepo {
  StatementClinet client = StatementClinet();

  Future<List<Statement>> getStatements() async {
    var response = await client.getStatements(MyApp.appUser!.id);

    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Statement>((json) => Statement.fromMap(json)).toList();
    }
    return [];
  }

  Future<Statement?> createStatement(
      firstSideId, secondSideId, statement, amount, date) async {
    var createdStatement = await client.createStatement(
        firstSideId, secondSideId, statement, amount, date);
    if (createdStatement != null) {
      return Statement.fromMap(jsonDecode(createdStatement));
    }
    return null;
  }
}
