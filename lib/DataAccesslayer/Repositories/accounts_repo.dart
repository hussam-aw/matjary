import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:matjary/DataAccesslayer/Clients/accounts_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/main.dart';

class AccountsRepo {
  AccountsClient client = AccountsClient();

  Future<List<Account>> getAccounts(connected) async {
    var response = await client.getAccounts(connected);
    if (response != "") {
      var parsed = response;
      if (connected) {
        parsed = json.decode(response).cast<Map<String, dynamic>>();
      }
      return parsed.map<Account>((json) => Account.fromMap(json)).toList();
    }
    return [];
  }

  Future<double> getCashAmount() async {
    var response = await client.getCashAmount();
    if (kDebugMode) {
      print(response);
    }
    final parsed = json.decode(response);
    return parsed.toDouble();
  }

  Future<bool> createAccount(
      name, balance, type, style, email, address, mobileNumber, image) async {
    var accountFieldsMap = {};
    accountFieldsMap = {
      'primaryFileds': {
        'name': name.toString(),
        "balance": balance.toString(),
        "type": type.toString(),
        "style": style.toString(),
        "email": email.toString(),
        "address": address.toString(),
        "phone": mobileNumber.toString(),
        "user_id": MyApp.appUser!.id.toString(),
        'company_id': MyApp.appUser!.companyId.toString(),
      },
      'files': image,
    };
    bool isAccountCreated = await client.createAccount(accountFieldsMap);
    if (isAccountCreated) {
      return true;
    }
    return false;
  }

  Future<bool> updateAccount(id, name, balance, type, style, image) async {
    var accountFieldsMap = {};
    accountFieldsMap = {
      'primaryFileds': {
        'name': name.toString(),
        "balance": balance.toString(),
        "type": type.toString(),
        "style": style.toString(),
        "user_id": MyApp.appUser!.id.toString(),
        'company_id': MyApp.appUser!.companyId.toString(),
      },
      'files': image,
    };
    bool isAccountUpdated = await client.updateAccount(id, accountFieldsMap);
    if (isAccountUpdated) {
      return true;
    }
    return false;
  }

  Future<bool> deleteAccount(id) async {
    bool isAccountDeleted = await client.deleteAccount(id);
    if (isAccountDeleted) {
      return true;
    }
    return false;
  }
}
