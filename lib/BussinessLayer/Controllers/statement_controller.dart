import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController statementAmountController =
      TextEditingController(text: "0.0");

  void setFromAccountInDropdownButton(accountName) {
    fromAccountController = TextEditingController(text: accountName);
    update();
  }

  void setToAccountInDropdownButton(accountName) {
    toAccountController = TextEditingController(text: accountName);
    update();
  }
}
