import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/account_statement.dart';
import 'package:matjary/DataAccesslayer/Repositories/account_statement_repo.dart';

class AccountStatementController extends GetxController {
  String? filterType;
  int? accountId;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  AccountStatementRepo accountStatementRepo = AccountStatementRepo();
  AccountStatement? accountStatement;
  var isLoadingAccountStatement = false.obs;

  void setAccountStatementFilterType(type) {
    filterType = type;
  }

  void setAccountId(id) {
    accountId = id;
  }

  String getDateString(date) {
    if (date.isEmpty) {
      return DateFormatter.getCurrentDateString();
    }
    return date;
  }

  void setFromDate(String date) {
    fromDateController.value = TextEditingValue(text: getDateString(date));
  }

  void setToDate(String date) {
    toDateController.value = TextEditingValue(text: getDateString(date));
  }

  void setDefaultFields() {
    setAccountStatementFilterType('all');
    setFromDate('');
    setToDate('');
  }

  Future<void> getAccountStatementBasedOnType() async {
    isLoadingAccountStatement.value = true;
    accountStatement = await accountStatementRepo.getAccountStatemntBasedOnType(
        filterType, accountId, fromDateController.text, toDateController.text);
    isLoadingAccountStatement.value = false;
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
