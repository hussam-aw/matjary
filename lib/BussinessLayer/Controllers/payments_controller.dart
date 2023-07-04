import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/DataAccesslayer/Repositories/payments_repo.dart';

class PaymentsController extends GetxController {
  List<Payment> payments = [];
  PaymentsRepo paymentsRepo = PaymentsRepo();
  var isLoading = false.obs;

  Future<void> getPayments() async {
    isLoading.value = true;
    payments = await paymentsRepo.getPayments();
    isLoading.value = false;
  }
}
