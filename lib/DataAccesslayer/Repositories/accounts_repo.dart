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
      id, name, balance, type, style, email, address, mobileNumber) async {
    var createdAccount = await client.createAccount(
        id, name, balance, type, style, email, address, mobileNumber);
    print(createdAccount);
    if (createdAccount != null) {
      return Account.fromMap(jsonDecode(createdAccount));
    }
    return null;
  }

  Future<Account?> updateAccount(id, name, balance, type, style) async {
    var updatedAccount =
        await client.updateAccount(id, name, balance, type, style);
    print(updatedAccount);
    if (updatedAccount != null) {
      return Account.fromMap(jsonDecode(updatedAccount));
    }
    return null;
  }

  Future<Account?> deleteAccount(id) async {
    var deletedAccount = await client.deleteAccount(id);
    print(deletedAccount);
    if (deletedAccount != null) {
      return Account.fromMap(jsonDecode(deletedAccount));
    }
    return null;
  }
}
