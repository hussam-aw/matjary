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

  void setFromAccount(Account? account) {
    fromAccount = account;
    if (account != null) {
      fromAccountName.value = account.name;
      fromAccountController.value = TextEditingValue(text: account.name);
    }
  }

  void setToAccount(Account? account) {
    toAccount = account;
    if (account != null) {
      toAccountName.value = account.name;
      toAccountController.value = TextEditingValue(text: account.name);
    }
  }

  void setAmount(amount) {
    statementAmount.value = amount;
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
  }

  String getDateString(date) {
    if (date.isEmpty) {
      return DateFormatter.getCurrentDateString();
    }
    return date;
  }

  void setDate(date) {
    dateController.value = TextEditingValue(text: getDateString(date));
  }

  void setStatementText(accountName) {
    statementTextController.value =
        TextEditingValue(text: 'تسجيل دفعة نقدية من الزبون $accountName');
  }

  void setDefaultAccounts() async {
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
  }

  Future<void> createStatement() async {
    String fromId = fromAccount!.id.toString();
    String toId = toAccount!.id.toString();
    num amount = getAmount();
    String date = dateController.text;
    String statementText = statementTextController.text;
    if (fromId.isNotEmpty &&
        toId.isNotEmpty &&
        date.isNotEmpty &&
        statementText.isNotEmpty) {
      loading.value = true;
      var statement = await statementRepo.createStatement(
        fromAccount!.id,
        toAccount!.id,
        statementText,
        amount,
        date,
      );
      loading.value = false;
      if (statement != null) {
        boxClient.setFirstSideAccount(fromAccount!.id);
        boxClient.setSecondSideAccount(toAccount!.id);
        await accountsController.getAccounts();
        SnackBars.showSuccess('تم انشاء القيد المحاسبي');
      } else {
        SnackBars.showError('فشل انشاء القيد المحاسبي');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  void setDefaultFields() {
    setDefaultAccounts();
    //setAmount('0');
    setDate('');
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
