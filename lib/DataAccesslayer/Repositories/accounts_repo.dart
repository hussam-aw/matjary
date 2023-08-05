import 'dart:convert';
import 'package:matjary/DataAccesslayer/Clients/accounts_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';

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

  // Future<List<Account>> getBankAccounts() async {
  //   var response = await client.getBankAccounts();
  //   if (response != "") {
  //     final parsed = json.decode(response).cast<Map<String, dynamic>>();

  //     return parsed
  //         .map<BankAccount>((json) => BankAccount.fromMap(json))
  //         .toList();
  //   }
  //   return [];
  // }

  // Future<List<Account>> getClientAccounts() async {
  //   var response = await client.getClientAccounts();
  //   if (response != "") {
  //     final parsed = json.decode(response).cast<Map<String, dynamic>>();

  //     return parsed
  //         .map<ClientAccount>((json) => ClientAccount.fromMap(json))
  //         .toList();
  //   }
  //   return [];
  // }

  Future<double> getCashAmount() async {
    var response = await client.getCashAmount();

    final parsed = json.decode(response);

    return parsed.toDouble();
  }

  Future<bool?> createAccount(
      name, balance, type, style, email, address, mobileNumber, image) async {
    var createdAccount = await client.createAccount(
        name, balance, type, style, email, address, mobileNumber, image);
    if (createdAccount != null) {
      return true;
    }
    return null;
  }

  Future<bool?> updateAccount(id, name, balance, type, style, image) async {
    var updatedAccount =
        await client.updateAccount(id, name, balance, type, style, image);
    if (updatedAccount != null) {
      return true;
    }
    return null;
  }

  Future<Account?> deleteAccount(id) async {
    var deletedAccount = await client.deleteAccount(id);
    if (deletedAccount != null) {
      return Account.fromMap(jsonDecode(deletedAccount));
    }
    return null;
  }
}
