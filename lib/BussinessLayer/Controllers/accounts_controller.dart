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
  List<Account> customersAccounts = [];
  var isLoadingCashAmount = false.obs;
  var cashAmount = 0.0.obs;
  AccountsRepo accountsRepo = AccountsRepo();

  Future<void> getAccounts() async {
    isLoadingAccounts.value = true;
    accounts = await accountsRepo.getAccounts();
    getBankAcoounts();
    getClientAcoounts();
    getSupplierAccounts();
    getMarketerAccounts();
    getCustomersAccounts();
    isLoadingAccounts.value = false;
  }

  Future<void> getBankAcoounts() async {
    bankAccounts = accounts.where((account) => account.style == 1).toList();
  }

  void getClientAcoounts() {
    clientAccounts = accounts.where((account) => account.style == 2).toList();
  }

  void getCustomersAccounts() {
    customersAccounts = accounts
        .where((account) =>
            account.style == 2 || account.style == 3 || account.style == 10)
        .toList();
  }

  void getSupplierAccounts() {
    supplierAccounts = accounts.where((account) => account.style == 3).toList();
  }

  void getMarketerAccounts() {
    marketerAccounts =
        accounts.where((account) => account.style == 10).toList();
  }

  void getAccountsBasedOnStyle(style) async {
    switch (style) {
      case 'bank':
        await getBankAcoounts();
        await getCachAmount();
        break;
      case 'client':
        getClientAcoounts();
        break;
      case 'customers':
        getCustomersAccounts();
        break;
      case 'marketer':
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
      case 'customers':
        return customersAccounts;
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

  Future<void> getCachAmount() async {
    isLoadingCashAmount.value = true;
    cashAmount.value = await accountsRepo.getCashAmount();
    isLoadingCashAmount.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
