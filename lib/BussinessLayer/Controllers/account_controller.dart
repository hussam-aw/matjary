import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

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

  int convertAccountTypeToNumber(type) {
    if (type == 'مدين') {
      return 0;
    } else {
      return 1;
    }
  }

  String convertAccountTypeToString(int type) {
    if (type == 0) {
      return 'مدين';
    } else {
      return 'دائن';
    }
  }

  int convertAccountStyleToNumber(style) {
    if (style == 'حساب عادي') {
      return 0;
    } else if (style == 'صندوق') {
      return 1;
    }
    return 2;
  }

  String convertAccountStyleToString(int style) {
    if (style == 0) {
      return 'حساب عادي';
    } else if (style == 1) {
      return 'صندوق';
    }
    return 'جهة عمل';
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
          MyApp.appUser!.id,
          name,
          int.parse(balance),
          convertAccountTypeToNumber(type),
          convertAccountStyleToNumber(style),
          email,
          address,
          mobileNumber);
      if (account != null) {
        SnackBars.showSuccess('تم انشاء الحساب');
      } else {
        SnackBars.showError('فشل انشاء الحساب');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  void setAcountDetails(Account? account) {
    if (account != null) {
      nameController = TextEditingController(text: account.name);
      balanceController =
          TextEditingController(text: account.balance.toString());
      type = convertAccountTypeToString(account.type);
      style = convertAccountStyleToString(account.style);
      emailController = TextEditingController(text: account.email);
      mobilePhoneController = TextEditingController(text: account.mobileNumber);
      addressController = TextEditingController(text: account.address);
    }
  }

  Future<void> updateAccount(int id) async {
    String name = nameController.text;
    int balance = int.parse(balanceController.text);
    var account = await accountsRepo.updateAccount(id, name, balance,
        convertAccountTypeToNumber(type), convertAccountStyleToNumber(style));
    if (account != null) {
      getAccounts();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteAccount(id) async {
    var account = await accountsRepo.deleteAccount(id);
    if (account != null) {
      getAccounts();
      SnackBars.showSuccess('تم الحذف بنجاح');
      update();
    } else {
      SnackBars.showError('فشل الحذف');
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
