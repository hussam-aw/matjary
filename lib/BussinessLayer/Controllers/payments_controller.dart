// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/DataAccesslayer/Repositories/payments_repo.dart';

class PaymentsController extends GetxController {
  List<Payment> payments = [];
  List<Payment> offlinePayments = [];
  PaymentsRepo paymentsRepo = PaymentsRepo();
  var isLoading = false.obs;

  Future<void> getPayments() async {
    isLoading.value = true;
    payments = await paymentsRepo.getPayments();
    isLoading.value = false;
  }

  Future<void> syncOfflinePayments() async {
    offlinePayments = await paymentsRepo.getOfflinePayments();
    bool isCreatedPayment;
    for (var payment in offlinePayments) {
      isCreatedPayment = await paymentsRepo.createPayment(
        true,
        payment.type,
        payment.counterPartyId,
        payment.bankId,
        payment.statement,
        payment.amount,
        DateFormatter.getFormated(payment.createdAt),
      );
    }
  }
}
