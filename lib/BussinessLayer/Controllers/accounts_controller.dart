import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';

class AccountsController extends GetxController {
  List<Account> accounts = [];
  var isLoadingAccounts = false.obs;
  List<Account> bankAccounts = [];
  var isLoadingBankAccounts = false.obs;
  List<Account> clientAccounts = [];
  var isLoadingClientAccounts = false.obs;
  List<Account> supplierAccounts = [];
  var isLoadingSupplierAccounts = false.obs;
  List<Account> employeeAccounts = [];
  var isLoadingEmployeeAccounts = false.obs;
  List<Account> marketerAccounts = [];
  var isLoadingMarketerAccounts = false.obs;
  List<Account> clientAndSupplierAccounts = [];
  AccountsRepo accountsRepo = AccountsRepo();

  Future<void> getAcoounts() async {
    isLoadingAccounts.value = true;
    accounts = await accountsRepo.getAccounts();
    isLoadingAccounts.value = false;
  }

  Future<void> getBankAcoounts() async {
    isLoadingBankAccounts.value = true;
    bankAccounts = accounts.where((account) => account.style == 1).toList();
    isLoadingBankAccounts.value = false;
  }

  Future<void> getClientAcoounts() async {
    isLoadingClientAccounts.value = true;
    clientAccounts = accounts.where((account) => account.style == 2).toList();
    isLoadingClientAccounts.value = false;
  }

  void getClientsAndSupplierAccounts() {
    clientAndSupplierAccounts = accounts
        .where((account) => account.style == 2 || account.style == 3)
        .toList();
  }

  void getMarketerAccounts() {
    marketerAccounts =
        accounts.where((account) => account.style == 10).toList();
  }

  Future<void> getAccountsBasedOnStyle(style) async {
    switch (style) {
      case 1:
        await getBankAcoounts();
        break;
      case 2:
        await getClientAcoounts();
        break;
      case 10:
        getMarketerAccounts();
        break;
    }
  }

  List<Account> getAccountsList(style) {
    switch (style) {
      case 'bank':
        return bankAccounts;
      case 'client':
        return clientAccounts;
      case 'clientsAndSuppliers':
        return clientAndSupplierAccounts;
      case 'marketer':
        return marketerAccounts;
    }
    return accounts;
  }

  Account? getAccountFromId(accountId) {
    var account =
        accounts.firstWhereOrNull((account) => account.id == accountId);
    if (account != null) {
      return account;
    }
    return null;
  }

  String getAccountName(int id) {
    return getAccountFromId(id) != null ? getAccountFromId(id)!.name : '';
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
