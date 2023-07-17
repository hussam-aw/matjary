import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/DataAccesslayer/Repositories/earns_expenses_repo.dart';

class EarnsExpensesController extends GetxController {
  List<StatementWithType> statemets = [];
  List<StatementWithType> currentStatements = [];
  List<StatementWithType> filteredStatements = [];
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

  Future<void> getStatements() async {
    isLoading.value = true;
    statemets = await earnsExpensesRepo.getStatements();
    isLoading.value = false;
    currentStatements = statemets;
  }

  Future<void> getStatementsByType(String type) async {
    isLoading.value = true;
    statemets = await earnsExpensesRepo.getStatements();
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
