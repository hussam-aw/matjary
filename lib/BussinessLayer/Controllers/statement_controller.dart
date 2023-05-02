import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController statementAmountController =
      TextEditingController(text: "0.0");

  void setFromAccount(accountName) {
    fromAccountController = TextEditingController(text: accountName);
  }

  void setToAccount(accountName) {
    toAccountController = TextEditingController(text: accountName);
  }

  void setAccountBasedOnType(accountName, type) {
    if (type == "from") {
      setFromAccount(accountName);
    } else if (type == "to") {
      setToAccount(accountName);
    }
    update();
    Get.back();
  }
}
