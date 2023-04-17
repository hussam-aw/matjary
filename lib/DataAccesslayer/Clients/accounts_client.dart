import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class AccountsClient {
  Future<dynamic> getAccounts() async {
    var response = await http.get(Uri.parse("$baseUrl$accountsLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getBankAccounts() async {
    var response = await http.get(Uri.parse("$baseUrl$bankAccountsLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getClientAccounts() async {
    var response = await http.get(Uri.parse("$baseUrl$clientAccoutsLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createAccount(
      name, balance, type, style, email, address, mobileNumber) async {
    var response = await http.post(Uri.parse('$baseUrl$addAccountLink'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "balance": balance,
          "type": type,
          "style": style,
          "email": email,
          "address": address,
          "phone": mobileNumber,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
