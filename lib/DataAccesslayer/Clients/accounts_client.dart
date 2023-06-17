import 'dart:convert';
import 'package:matjary/main.dart';
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
    var response = await http
        .get(Uri.parse("$baseUrl$clientAccoutsLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createAccount(
      id, name, balance, type, style, email, address, mobileNumber) async {
    var response = await http.post(Uri.parse('$baseUrl$accountLink'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "balance": balance,
          "type": type,
          "style": style,
          "email": email,
          "address": address,
          "phone": mobileNumber,
          "user_id": MyApp.appUser!.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> updateAccount(id, name, balance, type, style) async {
    var response = await http.post(Uri.parse('$baseUrl$accountLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "user_id": MyApp.appUser!.id,
          "name": name,
          "balance": balance,
          "type": type,
          "style": style,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteAccount(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$accountLink/$id'));

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
