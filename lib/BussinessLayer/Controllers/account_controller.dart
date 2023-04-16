import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';

class AccountController extends GetxController {
  AccountsRepo accountsRepo = AccountsRepo();
  List<Account> accounts = [];
  var isLoadingAccounts = false.obs;

  Future<void> getAccounts() async {
    isLoadingAccounts.value = true;
    accounts = await accountsRepo.getAccounts();
    print(accounts);
    isLoadingAccounts.value = false;
  }

  @override
  void onInit() {
    getAccounts();
    super.onInit();
  }
}
