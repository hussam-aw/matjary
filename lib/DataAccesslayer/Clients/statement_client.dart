import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class StatementClinet {
  Future<dynamic> getStatements(id) async {
    var response = await http.get(Uri.parse("$baseUrl$statementsLink/$id"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createStatement(
      firstSideId, secondSideId, statement, amount, date) async {
    var response = await http.post(Uri.parse('$baseUrl$statementLink'),
        body: jsonEncode(<String, dynamic>{
          "first_side_id": firstSideId,
          "second_side_id": secondSideId,
          "user_id": MyApp.appUser!.id,
          'type': 'other',
          "statement": statement,
          "amount": amount,
          "date": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
