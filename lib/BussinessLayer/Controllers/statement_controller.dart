import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  String fromAccount = "";
  String toAccount = "";
  TextEditingController statementAmountController =
      TextEditingController(text: "0.0");

  void setFromAccountInDropdownButton(accountName) {
    fromAccount = accountName;
    update();
  }

  void setToAccountInDropdownButton(accountName) {
    toAccount = accountName;
    update();
  }
}
