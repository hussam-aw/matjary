import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';

class PaymentScreenController extends GetxController {
  final paymentController = Get.put(PaymentController());

  List<String> paymentTypes = [
    'مقبوضات',
    'مدفوعات',
  ];

  List<String> counterPaymentTypes = [
    'income',
    'payment',
  ];

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
    if (type != null) {
      resetPaymentType();
      paymentTypesSelection[type] = true;
    }
  }

  void changePaymentType(type) {
    setPaymentType(type);
    update();
  }

  String getPaymentType(type) {
    return type == 'income' ? 'مقبوضات' : 'مدفوعات';
  }

  IconData getPaymenetTypeIcon(type) {
    return type == 'income'
        ? FontAwesomeIcons.solidCircleDown
        : FontAwesomeIcons.solidCircleUp;
  }

  void selectDate(date) async {
    if (date != null) {
      paymentController.setDate(DateFormatter.getFormated(date));
    } else {
      paymentController.setDate('');
    }
  }
}
