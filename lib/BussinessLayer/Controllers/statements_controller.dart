import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';

class StatementsController extends GetxController {
  List<Statement> statements = [];
  StatementRepo statementRepo = StatementRepo();
  var isLoading = false.obs;

  Future<void> getStatements() async {
    isLoading.value = true;
    statements = await statementRepo.getStatements();
    isLoading.value = false;
    print(statements);
  }
}
