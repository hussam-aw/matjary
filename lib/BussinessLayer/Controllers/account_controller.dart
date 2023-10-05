import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class AccountController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  String? type;
  String? style;
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String accountImage = '';
  AccountsRepo accountsRepo = AccountsRepo();
  AccountsController accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;
  var savingState = false;
  bool accountStyleForInformation = false;
  final connectivityController = Get.find<ConnectivityController>();

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
    } else if (style == 'زبون') {
      return 2;
    } else if (style == 'مورد') {
      return 3;
    } else if (style == 'جهة عمل') {
      return 4;
    } else if (style == 'مسوق') {
      return 10;
    }
    return 5;
  }

  String convertAccountStyleToString(int style) {
    if (style == 0) {
      return 'حساب عادي';
    } else if (style == 1) {
      return 'صندوق';
    } else if (style == 2) {
      return 'زبون';
    } else if (style == 3) {
      return 'مورد';
    } else if (style == 4) {
      return 'جهة عمل';
    } else if (style == 10) {
      return 'مسوق';
    }
    return '';
  }

  void changeAccountStyle(style1) {
    if (style1 == 'customers' || style1 == 'employers') {
      style = 'زبون';
      accountStyleForInformation = true;
    } else if (style1 == 'marketer') {
      style = 'مسوق';
      accountStyleForInformation = true;
    } else if (style1 == 'bank') {
      style = 'صندوق';
      accountStyleForInformation = false;
    } else {
      style = style1;
      accountStyleForInformation = checkAccountStyleForInformation(style);
    }
    print(accountStyleForInformation);
    update();
  }

  bool checkAccountStyleForInformation(style) {
    switch (style) {
      case 'حساب عادي':
        return false;
      case 'صندوق':
        return false;
      default:
        return true;
    }
  }

  void setAccountName(name) {
    if (name.isNotEmpty) {
      nameController.value = TextEditingValue(text: name);
    } else {
      nameController.clear();
    }
  }

  String getAccountName() {
    return nameController.text;
  }

  void setAccountBalance(balance) {
    if (balance.isNotEmpty) {
      balanceController = TextEditingController(text: balance);
    } else {
      balanceController.clear();
    }
  }

  num getAccountBalance() {
    return balanceController.text.isEmpty
        ? 0
        : num.parse(balanceController.text);
  }

  void setAccountType(accountType) {
    print(type);
    type = accountType;
  }

  int getAccountType() {
    return convertAccountTypeToNumber(type);
  }

  void setAccountStyle(accountStyle) {
    style = accountStyle;
    accountStyleForInformation = checkAccountStyleForInformation(accountStyle);
    update();
  }

  int getAccountStyle() {
    return convertAccountStyleToNumber(style);
  }

  void setAccountEmail(email) {
    if (email.isNotEmpty) {
      emailController.value = TextEditingValue(text: email);
    } else {
      emailController.clear();
    }
  }

  String getAccountEmail() {
    return emailController.text;
  }

  void setAccountMobilePhone(mobilePhone) {
    if (mobilePhone.isNotEmpty) {
      mobilePhoneController.value = TextEditingValue(text: mobilePhone);
    } else {
      mobilePhoneController.clear();
    }
  }

  String getAccountMobilePhone() {
    return mobilePhoneController.text;
  }

  void setAccountAddress(address) {
    if (address.isNotEmpty) {
      addressController.value = TextEditingValue(text: address);
    } else {
      addressController.clear();
    }
  }

  String getAccountAddress() {
    return addressController.text;
  }

  void setSelectedAccountImage(path) {
    accountImage = path;
  }

  void setAcountDetails(Account? account) {
    if (account != null) {
      setAccountName(account.name);
      setAccountBalance(account.balance.toString());
      setAccountType(convertAccountTypeToString(account.type));
      setAccountStyle(convertAccountStyleToString(account.style));
      setAccountEmail(account.email);
      setAccountMobilePhone(account.mobileNumber);
      setAccountAddress(account.address);
    } else {
      setAccountName('');
      setAccountBalance('');
      setAccountType('مدين');
      if (style == null || style == '') {
        setAccountStyle('حساب عادي');
      }

      setAccountEmail('');
      setAccountMobilePhone('');
      setAccountAddress('');
    }
  }

  Future<void> createAccount() async {
    savingState = false;
    String name = getAccountName();
    num balance = getAccountBalance();
    int accounttype = getAccountType();
    int accountStyle = getAccountStyle();
    String email = getAccountEmail();
    String mobileNumber = getAccountMobilePhone();
    String address = getAccountAddress();
    bool connected = connectivityController.isConnected;
    if (connected) {
      if (name.isNotEmpty && type!.isNotEmpty && style!.isNotEmpty) {
        loading.value = true;
        bool isAccountCreated = await accountsRepo.createAccount(
            name,
            balance,
            accounttype,
            accountStyle,
            email,
            address,
            mobileNumber,
            accountImage);
        loading.value = false;
        if (isAccountCreated) {
          await accountsController.getAccounts();
          savingState = true;
          setAcountDetails(null);
          SnackBars.showSuccess('تم انشاء الحساب');
        } else {
          SnackBars.showError('فشل انشاء الحساب');
        }
      } else {
        SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
      }
    } else {
      SnackBars.showError('لا يوجد اتصال بالانترنت');
    }
  }

  Future<void> updateAccount(int id) async {
    String name = getAccountName();
    num balance = getAccountBalance();
    int accounttype = getAccountType();
    int accountStyle = getAccountStyle();
    bool connected = connectivityController.isConnected;
    if (connected) {
      if (name.isNotEmpty && type!.isNotEmpty && style!.isNotEmpty) {
        loading.value = true;
        bool isAccountUpdated = await accountsRepo.updateAccount(
            id, name, balance, accounttype, accountStyle, accountImage);
        loading.value = false;
        if (isAccountUpdated) {
          await accountsController.getAccounts();
          SnackBars.showSuccess('تم التعديل بنجاح');
        } else {
          SnackBars.showError('فشل التعديل');
        }
      } else {
        SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
      }
    } else {
      SnackBars.showError('لا يوجد اتصال بالانترنت');
    }
  }

  Future<void> deleteAccount(id) async {
    bool connected = connectivityController.isConnected;
    if (connected) {
      loading.value = true;
      var isAccountDeleted = await accountsRepo.deleteAccount(id);
      loading.value = false;
      if (isAccountDeleted) {
        await accountsController.getAccounts();
        if (accountsController.checkIfAccountInAccountList(
            accountsController.pinnedAccounts, id)) {
          boxClient.removeFromPinnedAccountList(id);
          await accountsController.getPinnedAccounts();
        }
        SnackBars.showSuccess('تم الحذف بنجاح');
      } else {
        SnackBars.showError('فشل الحذف');
      }
    } else {
      SnackBars.showError('لا يوجد اتصال بالانترنت');
    }
  }

  Future<void> pinAccountToHomeScreen(accountId) async {
    if (!accountsController.checkIfAccountInAccountList(
        accountsController.pinnedAccounts, accountId)) {
      await boxClient.setAccountToPinnedAccountList(accountId);
      await accountsController.getPinnedAccounts();
      SnackBars.showSuccess('تم تثبيت الحساب في الشاشة الرئيسية');
    } else {
      await boxClient.removeFromPinnedAccountList(accountId);
      await accountsController.getPinnedAccounts();
      SnackBars.showSuccess('تم إلغاءالتثبيت');
    }
  }

  bool checkAccountIsPinned(accountId) {
    return accountsController.checkIfAccountInAccountList(
        accountsController.pinnedAccounts, accountId);
  }
}
