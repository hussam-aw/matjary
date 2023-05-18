import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';

class StatementScreenController extends GetxController {
  final statementController = Get.find<StatementController>();

  DateTime? selectedDate;

  void setAccountBasedOnType(Account? account, type) {
    if (account != null) {
      if (type == "from") {
        statementController.setFromAccount(account);
        statementController.setStatementText(account.name);
      } else if (type == "to") {
        statementController.setToAccount(account);
      }
    }
  }

  void selectDate(date) async {
    if (date != null) {
      statementController.setDate(date.toString().substring(0, 10));
      update();
    }
  }
}
