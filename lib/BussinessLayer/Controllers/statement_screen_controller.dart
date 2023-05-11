import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';

class StatementScreenController extends GetxController {
  final statementController = Get.find<StatementController>();

  var selectionAccount = false.obs;
  var fromAcount = ''.obs;
  var toAccount = ''.obs;
  var statementAmount = ''.obs;
  DateTime? selectedDate;

  void setAccountBasedOnType(Account? account, type) {
    if (account != null) {
      selectionAccount.value = true;
      if (type == "from") {
        fromAcount.value = account.name;
        statementController.setFromAccount(account.name);
        statementController.setStatementText(account.name);
      } else if (type == "to") {
        toAccount.value = account.name;
        statementController.setToAccount(account.name);
      }
      selectionAccount.value = false;
    }
  }

  void setAmount(String amount) {
    if (amount.isNotEmpty) {
      var parsedAmount = num.parse(amount);
      if (parsedAmount > 0.0) statementAmount.value = amount;
    } else {
      statementAmount.value = '';
    }
  }

  void selectDate(date) async {
    if (date != null) {
      statementController.setDate(date.toString().substring(0, 10));
      update();
    }
  }
}
