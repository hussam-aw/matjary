import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
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
  //var isLoadingCashAmount = false.obs;
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
    await getCachAmount();
    isLoadingAccounts.value = false;
  }

  Future<void> getBankAcoounts() async {
    isLoadingBankAccounts.value = true;
    bankAccounts = accounts.where((account) => account.style == 1).toList();
    isLoadingBankAccounts.value = false;
  }

  void getClientAcoounts() {
    clientAccounts = accounts.where((account) => account.style == 2).toList();
  }

  void getSupplierAccounts() {
    supplierAccounts = accounts.where((account) => account.style == 3).toList();
  }

  void getMarketerAccounts() {
    marketerAccounts =
        accounts.where((account) => account.style == 10).toList();
  }

  void getCustomersAccounts() {
    customersAccounts = accounts
        .where((account) =>
            account.style == 2 || account.style == 3 || account.style == 10)
        .toList();
  }

  void getAccountsBasedOnStyle(style) async {
    switch (style) {
      case 'bank':
        getBankAcoounts();
        await getCachAmount();
        break;
      case 'client':
        getClientAcoounts();
        getCustomersAccounts();
        break;
      case 'supplier':
        getSupplierAccounts();
        getCustomersAccounts();
        break;
      case 'marketer':
        getMarketerAccounts();
        getCustomersAccounts();
        break;
      case 'customers':
        getCustomersAccounts();
        break;
    }
  }

  List<Account> getAccountsList(style) {
    switch (style) {
      case 'bank':
        return bankAccounts;
      case 'client':
        return clientAccounts;

      case 'marketer':
        return marketerAccounts;
      case 'customers':
        return customersAccounts;
      case 'employers':
        return customersAccounts;
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
    cashAmount.value = await accountsRepo.getCashAmount();
  }

  Future<Account> selectAccount(accountList) async {
    return await Get.toNamed(
      AppRoutes.chooseAccountScreen,
      arguments: {
        'mode': 'selection',
        'accounts': accountList,
      },
    );
  }
}
