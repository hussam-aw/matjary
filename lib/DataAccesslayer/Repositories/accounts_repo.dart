import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/accounts_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/bank_account.dart';
import 'package:matjary/DataAccesslayer/Models/client_account.dart';

class AccountsRepo {
  AccountsClient client = AccountsClient();

  Future<List<Account>> getAccounts() async {
    var response = await client.getAccounts();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();

      return parsed.map<Account>((json) => Account.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Account>> getBankAccounts() async {
    var response = await client.getBankAccounts();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();

      return parsed
          .map<BankAccount>((json) => BankAccount.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<List<Account>> getClientAccounts() async {
    var response = await client.getClientAccounts();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();

      return parsed
          .map<ClientAccount>((json) => ClientAccount.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<Account?> createAccount(
      name, balance, type, style, email, address, mobileNumber) async {
    var createdAccount = await client.createAccount(
        name, balance, type, style, email, address, mobileNumber);
    print(createdAccount);
    if (createdAccount != null) {
      return Account.fromMap(jsonDecode(createdAccount));
    }
    return null;
  }
}
