import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/earn_expense_controller.dart';
import 'package:matjary/BussinessLayer/Helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';

class EarnExapenseScreenController extends GetxController {
  final earnExpenseController = Get.put(EarnExpenseController());
  List<String> statementTypes = [
    'إيرادات',
    'مصاريف',
  ];

  Map<String, String> counterStatementTypes = {
    'revenues': 'إيرادات',
    'expenses': 'مصاريف',
  };

  Map<String, bool> statementTypeSelection = {
    'إيرادات': true,
    'مصاريف': false,
  };

  void resetStatementType() {
    statementTypeSelection = {
      'إيرادات': false,
      'مصاريف': false,
    };
  }

  void setStatementType(type) {
    if (type != null) {
      resetStatementType();
      statementTypeSelection[type] = true;
    }
  }

  void changeStatementType(type) {
    setStatementType(type);
    update();
  }

  String getStatementType(type) {
    return type == 'revenues' ? 'إيرادات' : 'مصاريف';
  }

  IconData getStatementTypeIcon(type) {
    return type == 'revenues'
        ? FontAwesomeIcons.solidCircleDown
        : FontAwesomeIcons.solidCircleUp;
  }

  void selectDate(date) async {
    if (date != null) {
      earnExpenseController.setDate(DateFormatter.getFormated(date));
    } else {
      earnExpenseController.setDate('');
    }
  }

  void setDefaultFields({StatementWithType? statement}) {
    if (statement != null) {
      setStatementType(counterStatementTypes[statement.type]);
    } else {
      setStatementType('إيرادات');
    }
  }
}
