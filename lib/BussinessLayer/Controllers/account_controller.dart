import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';

class AccountController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  String? type = 'مدين';
  String? style = 'حساب عادي';
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AccountsRepo accountsRepo = AccountsRepo();
  List<Account> accounts = [];
  List<Account> bankAccounts = [];
  List<Account> clientAccounts = [];
  var isLoadingAccounts = false.obs;

  Future<void> getAccounts() async {
    isLoadingAccounts.value = true;
    accounts = await accountsRepo.getAccounts();
    print(accounts);
    isLoadingAccounts.value = false;
  }

  Future<void> getBankAccounts() async {
    isLoadingAccounts.value = true;
    bankAccounts = await accountsRepo.getBankAccounts();
    print(bankAccounts);
    isLoadingAccounts.value = false;
  }

  Future<void> getClintAccounts() async {
    isLoadingAccounts.value = true;
    clientAccounts = await accountsRepo.getClientAccounts();
    print(clientAccounts);
    isLoadingAccounts.value = false;
  }

  int convertAccountType(type) {
    if (type == 'مدين') {
      return 1;
    } else {
      return 2;
    }
  }

  int convertAccountStyle(style) {
    if (style == 'حساب عادي') {
      return 1;
    } else if (style == 'صندوق') {
      return 2;
    }
    return 3;
  }

  Future<void> createAccount() async {
    String name = nameController.text;
    String balance = balanceController.text;
    String email = emailController.text;
    String mobileNumber = mobilePhoneController.text;
    String address = addressController.text;
    if (name.isNotEmpty &&
        balance.isNotEmpty &&
        type!.isNotEmpty &&
        style!.isNotEmpty &&
        email.isNotEmpty &&
        mobileNumber.isNotEmpty &&
        address.isNotEmpty) {
      var account = await accountsRepo.createAccount(
          name,
          int.parse(balance),
          convertAccountType(type),
          convertAccountStyle(style),
          email,
          address,
          mobileNumber);
      if (account != null) {
        print("ali");
      }
    } else {
      print('حقل مطلوب');
    }
  }

  @override
  void onInit() {
    getAccounts();
    //getBankAccounts();
    //getClintAccounts();
    super.onInit();
  }
}
