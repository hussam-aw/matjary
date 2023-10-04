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

  Future<bool> createAccount(connected, name, balance, type, style, email,
      address, mobileNumber, image) async {
    Map<String, Object?> accountFieldsMap = {};
    if (connected) {
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
    } else {
      accountFieldsMap = {
        'name': name,
        "balance": balance,
        "type": type,
        "style": style,
        "email": email,
        "address": address,
        "phone": mobileNumber,
        "avatar": image,
      };
    }
    bool? isAccountCreated =
        await client.createAccount(connected, accountFieldsMap);
    if (isAccountCreated != null && isAccountCreated) {
      return true;
    }
    return false;
  }

  Future<bool?> updateAccount(id, name, balance, type, style, image) async {
    var updatedAccount =
        await client.updateAccount(id, name, balance, type, style, image);
    if (updatedAccount != null) {
      return true;
    }
    return null;
  }

  Future<bool> deleteAccount(connected, id) async {
    var isAccountDeleted = await client.deleteAccount(connected, id);
    if (isAccountDeleted != null && isAccountDeleted) {
      return true;
    }
    return false;
  }
}
