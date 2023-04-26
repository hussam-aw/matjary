import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';

class HomeController extends GetxController {
  AccountsRepo accountsRepo = AccountsRepo();
  List<Account> accounts = [];
  List<Account> bankAccounts = [];
  List<Account> clientAccounts = [];
  var isLoadingAccounts = false.obs;
  Future<void> getAccounts() async {
    accounts = await accountsRepo.getAccounts();
    update();
  }

  Future<void> getBankAccounts() async {
    isLoadingAccounts.value = true;
    bankAccounts = await accountsRepo.getBankAccounts();
    isLoadingAccounts.value = false;
  }

  Future<void> getClintAccounts() async {
    isLoadingAccounts.value = true;
    clientAccounts = await accountsRepo.getClientAccounts();
    isLoadingAccounts.value = false;
  }

  @override
  void onInit() {
    getAccounts();
    getBankAccounts();
    getClintAccounts();
    super.onInit();
  }
}
