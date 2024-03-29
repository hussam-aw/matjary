// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/DataAccesslayer/Repositories/earns_expenses_repo.dart';

class EarnsExpensesController extends GetxController {
  List<StatementWithType> statemets = [];
  List<StatementWithType> currentStatements = [];
  List<StatementWithType> filteredStatements = [];
  List<StatementWithType> offlineStatements = [];
  EarnsExpensesRepo earnsExpensesRepo = EarnsExpensesRepo();
  var isLoading = false.obs;
  String currentStatementFilterType = 'الكل';

  List<String> filterTypes = [
    'الكل',
    'الإيرادات',
    'المصاريف',
  ];

  Map<String, String> statementFilterTypes = {
    'الإيرادات': 'expenses',
    'المصاريف': 'revenues',
  };

  RxMap<String, bool> statementFilterTypesSelection = {
    'الكل': true,
    'الإيرادات': false,
    'المصاريف': false,
  }.obs;

  void resetStatementFilterTypes() {
    statementFilterTypesSelection.value = {
      'الكل': false,
      'الإيرادات': false,
      'المصاريف': false,
    };
  }

  void setStatementFilterType(type) {
    resetStatementFilterTypes();
    currentStatementFilterType = type;
    statementFilterTypesSelection[type] = true;
  }

  Future<void> getEarnsAndExpenses() async {
    isLoading.value = true;
    statemets = await earnsExpensesRepo.getEarnsAndExpenses();
    isLoading.value = false;
    currentStatements = statemets;
  }

  Future<void> syncOfflineEarnsAndExpenses() async {
    offlineStatements = await earnsExpensesRepo.getOfflineEarnsAndExpenses();
    bool isCreatedPayment;
    for (var statement in offlineStatements) {
      isCreatedPayment = await earnsExpensesRepo.createStatementBsedOnType(
        true,
        statement.type,
        statement.statement,
        statement.amount,
        statement.bankId,
        DateFormatter.getFormated(statement.createdAt),
      );
    }
  }

  Future<void> getStatementsByType(String type) async {
    isLoading.value = true;
    statemets = await earnsExpensesRepo.getEarnsAndExpenses();
    if (type == 'الكل') {
      currentStatements = statemets;
    } else {
      currentStatements = statemets
          .where((statement) => statement.type == statementFilterTypes[type])
          .toList();
    }
    filteredStatements = currentStatements;
    isLoading.value = false;
  }
}
