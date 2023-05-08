import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "0.0");
  TextEditingController dateController = TextEditingController(
    text:
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
  );
  TextEditingController statementTextController = TextEditingController();
  StatementRepo statementRepo = StatementRepo();
  var homeController = Get.find<HomeController>();
  var loading = false.obs;

  void setFromAccount(accountName) {
    fromAccountController.value = TextEditingValue(text: accountName);
  }

  void setToAccount(accountName) {
    toAccountController.value = TextEditingValue(text: accountName);
  }

  String getAccountId(accountName) {
    var account = homeController.accounts
        .firstWhereOrNull((account) => account.name == accountName);
    if (account != null) {
      return account.id.toString();
    }
    return '';
  }

  void setDate(date) {
    dateController.value = TextEditingValue(text: date);
  }

  void setStatementText(accountName) {
    statementTextController.value =
        TextEditingValue(text: 'تسجيل دفعة نقدية من الزبون ${accountName}');
  }

  Future<void> createStatement() async {
    String fromId = getAccountId(fromAccountController.text);
    String toId = getAccountId(toAccountController.text);
    String amount = amountController.text;
    String date = dateController.text;
    String statementText = statementTextController.text;
    if (fromId.isNotEmpty &&
        toId.isNotEmpty &&
        amount.toString().isNotEmpty &&
        date.isNotEmpty &&
        statementText.isNotEmpty) {
      loading.value = true;
      var statement = await statementRepo.createStatement(
        int.parse(fromId),
        int.parse(toId),
        MyApp.appUser!.id,
        statementText,
        num.parse(amount),
        date,
      );
      loading.value = false;
      if (statement != null) {
        SnackBars.showSuccess('تم انشاء القيد المحاسبي');
      } else {
        SnackBars.showError('فشل انشاء القيد المحاسبي');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }
}
