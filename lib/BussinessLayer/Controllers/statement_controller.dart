import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  Account? fromAccount;
  RxString fromAccountName = ''.obs;
  TextEditingController toAccountController = TextEditingController();
  Account? toAccount;
  RxString toAccountName = ''.obs;
  Rx<TextEditingController> amountController =
      TextEditingController(text: "0").obs;
  RxString statementAmount = ''.obs;
  TextEditingController dateController = TextEditingController(
    text:
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
  );
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

  void setDate(date) {
    dateController.value = TextEditingValue(text: date);
  }

  void setStatementText(accountName) {
    statementTextController.value =
        TextEditingValue(text: 'تسجيل دفعة نقدية من الزبون ${accountName}');
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
    String amount = amountController.value.text;
    String date = dateController.text;
    String statementText = statementTextController.text;
    if (fromId.isNotEmpty &&
        toId.isNotEmpty &&
        amount.toString().isNotEmpty &&
        date.isNotEmpty &&
        statementText.isNotEmpty) {
      loading.value = true;
      var statement = await statementRepo.createStatement(
        fromAccount!.id,
        toAccount!.id,
        MyApp.appUser!.id,
        statementText,
        num.parse(amount),
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

  @override
  void onInit() {
    setDefaultAccounts();
    super.onInit();
  }
}
