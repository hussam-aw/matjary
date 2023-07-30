import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  Account? fromAccount;
  RxString fromAccountName = ''.obs;
  TextEditingController toAccountController = TextEditingController();
  Account? toAccount;
  RxString toAccountName = ''.obs;
  TextEditingController amountController = TextEditingController();
  RxString statementAmount = ''.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController statementTextController = TextEditingController();
  StatementRepo statementRepo = StatementRepo();
  var accountController = Get.find<AccountsController>();
  var accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;
  var savingState = false;

  void setFromAccount(Account? account) {
    fromAccount = account;
    if (account != null) {
      fromAccountName.value = account.name;
      fromAccountController.value = TextEditingValue(text: account.name);
      setStatementText(fromAccountName.value);
    } else {
      fromAccountName.value = '';
      fromAccountController.clear();
      statementTextController.clear();
    }
  }

  int? getFromAccountId() {
    if (fromAccount != null) {
      return fromAccount!.id;
    } else {
      return null;
    }
  }

  void setToAccount(Account? account) {
    toAccount = account;
    if (account != null) {
      toAccountName.value = account.name;
      toAccountController.value = TextEditingValue(text: account.name);
    } else {
      toAccountName.value = '';
      toAccountController.clear();
    }
  }

  int? getToAccountOd() {
    if (toAccount != null) {
      return toAccount!.id;
    } else {
      return null;
    }
  }

  void setAmount(amount) {
    if (amount.isNotEmpty) {
      statementAmount.value = amount;
    } else {
      statementAmount.value = '';
      amountController.clear();
    }
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
  }

  void setDate(date) {
    if (date.isNotEmpty) {
      dateController.value = TextEditingValue(text: date);
    } else {
      dateController.value =
          TextEditingValue(text: DateFormatter.getCurrentDateString());
    }
  }

  String getDate() {
    return dateController.text;
  }

  void setStatementText(accountName) {
    if (accountName.isNotEmpty) {
      statementTextController.value =
          TextEditingValue(text: 'تسجيل دفعة نقدية من الزبون $accountName');
    } else {
      statementTextController.clear();
    }
  }

  String getStatementText() {
    return statementTextController.text;
  }

  void setDefaultAccounts(clear) async {
    if (!clear) {
      Account? from, to;
      int? fromId, toId;
      fromId = await boxClient.getFirstSideAccount();
      toId = await boxClient.getSecondSideAccount();
      from = accountController.getAccountFromId(fromId);
      to = accountController.getAccountFromId(toId);
      if (from == null && to == null) {
        from = accountController.accounts.isNotEmpty
            ? accountController.accounts[0]
            : null;
        to = accountController.accounts.isNotEmpty
            ? accountController.accounts[1]
            : null;
      }
      setFromAccount(from);
      setToAccount(to);
      if (from != null) setStatementText(from.name);
    } else {
      setFromAccount(null);
      setToAccount(null);
    }
  }

  void setDefaultFields({bool clear = false}) {
    setDefaultAccounts(clear);
    setAmount('');
    setDate('');
    setStatementText('');
  }

  Future<void> createStatement() async {
    savingState = false;
    int? fromId = getFromAccountId();
    int? toId = getToAccountOd();
    num amount = getAmount();
    String date = getDate();
    String statementText = getStatementText();
    if (fromId != null &&
        toId != null &&
        date.isNotEmpty &&
        statementText.isNotEmpty) {
      loading.value = true;
      var statement = await statementRepo.createStatement(
        fromId,
        toId,
        statementText,
        amount,
        date,
      );
      loading.value = false;
      if (statement != null) {
        boxClient.setFirstSideAccount(fromId);
        boxClient.setSecondSideAccount(toId);
        await accountsController.getAccounts();
        savingState = true;
        setDefaultFields(clear: true);
        SnackBars.showSuccess('تم انشاء القيد المحاسبي');
      } else {
        SnackBars.showError('فشل انشاء القيد المحاسبي');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
