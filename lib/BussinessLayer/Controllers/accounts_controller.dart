import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
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
  var isLoadingPinnedAccounts = true.obs;
  List<Account> pinnedAccounts = [];
  var isLoadingCashAmount = true.obs;
  var cashAmount = 0.0.obs;
  AccountsRepo accountsRepo = AccountsRepo();
  BoxClient boxClient = BoxClient();

  String? swapStyle;
  Map<String, String> counterAccountStyle = {
    'bank': 'الصناديق النقدية',
    'client': 'الزبائن',
    'supplier': 'المزودين',
    'marketer': 'المسوقين',
    'customers': 'العملاء',
    'employers': 'جهات العمل'
  };

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

  void changeSwapStyle(swap) {
    /*   'bank': 'الصناديق النقدية',
    'client': 'الزبائن',
    'supplier': 'المزودين',
    'marketer': 'المسوقين',
    'customers': 'العملاء',
    'employers': 'جهات العمل'
     */
    switch (swap) {
      case 'bank':
        swapStyle = "";
        break;
      default:
    }
    swapStyle = swap;
    update();
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
    print(customersAccounts);
    update();
  }

  Future<void> getPinnedAccounts() async {
    isLoadingPinnedAccounts.value = true;
    var accountIds = await boxClient.getPinnedAccountsList();
    if (accountIds != null) {
      pinnedAccounts = accountIds.map((id) => getAccountFromId(id)!).toList();
    } else {
      pinnedAccounts = customersAccounts;
    }
    isLoadingPinnedAccounts.value = false;
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

  Future<void> getCachAmount() async {
    isLoadingCashAmount.value = true;
    cashAmount.value = await accountsRepo.getCashAmount();
    isLoadingCashAmount.value = false;
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
    return getAccountFromId(id) != null
        ? getAccountFromId(id)!.name
        : 'غير معين';
  }

  Future<dynamic> selectAccount(accountList, style) async {
    return await Get.toNamed(
      AppRoutes.chooseAccountScreen,
      arguments: {
        'mode': 'selection',
        'style': style,
        'accounts': accountList,
      },
    );
  }

  bool checkIfAccountInAccountList(List<Account> accounts, int accountId) {
    return accounts.map((account) => account.id).contains(accountId);
  }
}
