import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';

class StatementScreenController extends GetxController {
  final statementController = Get.find<StatementController>();

  var selectionAccount = false.obs;
  var fromAcount = ''.obs;
  var toAccount = ''.obs;
  var statementAmount = ''.obs;
  DateTime? selectedDate;

  void setAccountBasedOnType(accountName, type) {
    selectionAccount.value = true;
    if (type == "from") {
      fromAcount.value = accountName;
      statementController.setFromAccount(accountName);
      statementController.setStatementText(accountName);
    } else if (type == "to") {
      toAccount.value = accountName;
      statementController.setToAccount(accountName);
    }
    selectionAccount.value = false;
    Get.back();
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
