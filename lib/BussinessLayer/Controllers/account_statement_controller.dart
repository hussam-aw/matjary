import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account_statement.dart';
import 'package:matjary/DataAccesslayer/Repositories/account_statement_repo.dart';

class AccountStatementController extends GetxController {
  String filterType = 'all';
  int? accountId;
  AccountStatementRepo accountStatementRepo = AccountStatementRepo();
  AccountStatement? accountStatement;
  var isLoadingAccountStatement = false.obs;

  void setAccountStatementFilterType(type) {
    filterType = type;
  }

  void setAccountId(id) {
    accountId = id;
  }

  Future<void> getAccountStatementBasedOnType() async {
    isLoadingAccountStatement.value = true;
    accountStatement = await accountStatementRepo.getAccountStatemntBasedOnType(
        filterType, accountId, '', '');
    print(accountStatement!.total);
    isLoadingAccountStatement.value = false;
  }
}
