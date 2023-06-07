import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/DataAccesslayer/Models/statement.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';

class PaymentsController extends GetxController {
  List<Statement> payments = [];
  StatementRepo statementRepo = StatementRepo();
  var isLoading = false.obs;

  Future<void> getPayments() async {
    isLoading.value = true;
    payments = await statementRepo.getStatements();
    isLoading.value = false;
    print(payments);
  }
}
