// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';

class StatementsController extends GetxController {
  List<Statement> statements = [];
  List<Statement> offlineStatements = [];
  StatementRepo statementRepo = StatementRepo();
  var isLoading = false.obs;

  Future<void> getStatements() async {
    isLoading.value = true;
    statements = await statementRepo.getStatements();
    isLoading.value = false;
  }

  Future<void> syncOfflineStatements() async {
    offlineStatements = await statementRepo.getOfflineStatements();
    bool isCreatedStatement;
    for (var statement in offlineStatements) {
      isCreatedStatement = await statementRepo.createStatement(
        true,
        statement.firstSideId,
        statement.secondSideId,
        statement.statement,
        statement.amount,
        DateFormatter.getFormated(statement.createdAt),
      );
    }
  }
}
