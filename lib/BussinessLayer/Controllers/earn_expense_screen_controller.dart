import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EarnExapenseScreenController extends GetxController {
  List<String> transactionTypes = [
    'إيرادات',
    'مصاريف',
  ];

  List<String> counterTransactionType = [
    'revenues',
    'expenses',
  ];

  Map<String, bool> transactionTypeSelection = {
    'إيرادات': true,
    'مصاريف': false,
  };

  void resetTransactionType() {
    transactionTypeSelection = {
      'إيرادات': false,
      'مصاريف': false,
    };
  }

  void setTransactionType(type) {
    if (type != null) {
      resetTransactionType();
      transactionTypeSelection[type] = true;
    }
  }

  void changeTransactionType(type) {
    setTransactionType(type);
    update();
  }

  String getTransactionType(type) {
    return type == 'revenues' ? 'إيرادات' : 'مصاريف';
  }

  IconData getTransactionTypeIcon(type) {
    return type == 'revenues'
        ? FontAwesomeIcons.solidCircleDown
        : FontAwesomeIcons.solidCircleUp;
  }

  // void selectDate(date) async {
  //   if (date != null) {
  //     paymentController.setDate(DateFormatter.getFormated(date));
  //   } else {
  //     paymentController.setDate('');
  //   }
  // }
}
