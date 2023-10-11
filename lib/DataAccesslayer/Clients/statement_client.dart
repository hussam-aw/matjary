import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/main.dart';

class StatementClinet {
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<dynamic> getStatements() async {
    var response = await http
        .get(Uri.parse("$baseUrl$statementsLink/${MyApp.appUser!.id}"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getPayments() async {
    var response =
        await http.get(Uri.parse("$baseUrl$paymentsLink/${MyApp.appUser!.id}"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getEarnsAndExpenses() async {
    var response = await http.get(
        Uri.parse("$baseUrl$earnsExpensesLink/${MyApp.appUser!.companyId}"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getOfflineStatementsBasedOnType(types) async {
    var data = await databaseHelper.getData(
        offlineTransactionTableName, 'type', types);
    if (data.isNotEmpty) {
      await databaseHelper.delete(offlineTransactionTableName, 'type', types);
      return data;
    } else {
      return "";
    }
  }

  Future<dynamic> createStatement(connected, map) async {
    if (connected) {
      var response = await http.post(Uri.parse('$baseUrl$statementLink'),
          body: jsonEncode(map),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } else {
      var isInserted =
          await databaseHelper.insert(offlineTransactionTableName, map);
      return isInserted;
    }
  }

  Future<dynamic> updateStatement(id, map) async {
    var response = await http.post(Uri.parse('$baseUrl$statementLink/$id'),
        body: jsonEncode(map),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> deleteStatement(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$statementLink/$id'));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
