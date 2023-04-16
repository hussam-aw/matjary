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
}
