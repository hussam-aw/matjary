import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/account_statement_client.dart';
import 'package:matjary/DataAccesslayer/Models/account_statement.dart';

class AccountStatementRepo {
  AccountStatementClient client = AccountStatementClient();

  Future<AccountStatement?> getAccountStatemntBasedOnType(
      type, accountId, fromDate, toDate) async {
    var accountStatement = await client.getAccountStatementBasedOnType(
        type, accountId, fromDate, toDate);
    if (accountStatement != null) {
      return AccountStatement.fromMap(jsonDecode(accountStatement));
    }
    return null;
  }
}
