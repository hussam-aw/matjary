import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class EarnsExpensesClient {
  Future<dynamic> getStatements() async {
    var response = await http.get(
        Uri.parse("$baseUrl$earnsExpensesLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createStatementBasedOnType(
      type, statement, amount, bankId, date) async {
    var response = await http.post(Uri.parse('$baseUrl$earnExpenseLink'),
        body: jsonEncode(<String, dynamic>{
          "type": type,
          "statement": statement,
          "amount": amount,
          "bank_id": bankId,
          "date": date,
          "company_id": MyApp.appUser!.companyId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      return true;
    } else {
      return null;
    }
  }

  Future<dynamic> updateStatement(
      id, type, statement, amount, bankId, date) async {
    var response = await http.post(Uri.parse('$baseUrl$statementLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "type": type,
          "statement": statement,
          "amount": amount,
          "bank_id": bankId,
          "date": date,
          "user_id": MyApp.appUser!.companyId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteStatement(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$statementLink/$id'));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
