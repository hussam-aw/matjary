import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';

class PaymentScreenController extends GetxController {
  final paymentController = Get.find<PaymentController>();
  Map<String, String> paymentTypes = {
    'income': 'مقبوضات',
    'payment': 'مدفوعات',
  };

  Map<String, bool> paymentTypesSelection = {
    'مقبوضات': true,
    'مدفوعات': false,
  };

  void resetPaymentType() {
    paymentTypesSelection = {
      'مقبوضات': false,
      'مدفوعات': false,
    };
  }

  void setPaymentType(type) {
    resetPaymentType();
    paymentTypesSelection[type] = true;
    update();
  }

  void selectDate(date) async {
    print(date);
    if (date != null) {
      paymentController.setDate(DateFormatter.getFormated(date));
    } else {
      paymentController.setDate('');
    }
  }
}