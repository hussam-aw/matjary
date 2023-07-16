import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/DataAccesslayer/Repositories/earns_expenses_repo.dart';

class EarnsExpensesController extends GetxController {
  List<StatementWithType> statemets = [];
  EarnsExpensesRepo earnsExpensesRepo = EarnsExpensesRepo();
  var isLoading = false.obs;

  Future<void> getStatements() async {
    isLoading.value = true;
    statemets = await earnsExpensesRepo.getStatements();
    isLoading.value = false;
  }
}
