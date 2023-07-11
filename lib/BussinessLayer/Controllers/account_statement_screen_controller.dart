import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_statement_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/AccountStatements/account_statement_dates_bottom_sheet.dart';

class AccountStatementScreenController extends GetxController {
  String currentAccountStatementFilterType = 'عن كامل المدة';
  final accountStatementController = Get.put(AccountStatementController());

  List<String> accountStatementFilterTypes = [
    'عن كامل المدة',
    'آخر أسبوع',
    'بين تاريخين',
    'آخر شهر',
  ];

  Map<String, String> accountStatementTypes = {
    'عن كامل المدة': 'all',
    'آخر أسبوع': 'last_week',
    'بين تاريخين': 'between_dates',
    'آخر شهر': 'last_month',
  };

  RxMap<String, bool> accountStatementFilterTypesSelection = {
    'عن كامل المدة': true,
    'آخر أسبوع': false,
    'بين تاريخين': false,
    'آخر شهر': false,
  }.obs;

  void resetAccountStatementFilterTypes() {
    accountStatementFilterTypesSelection.value = {
      'عن كامل المدة': false,
      'آخر أسبوع': false,
      'بين تاريخين': false,
      'آخر شهر': false,
    };
  }

  void selectFromDate(date) async {
    print(date);
    if (date != null) {
      accountStatementController.setFromDate(DateFormatter.getFormated(date));
    } else {
      accountStatementController.setFromDate('');
    }
  }

  void selectToDate(date) async {
    print(date);
    if (date != null) {
      accountStatementController.setToDate(DateFormatter.getFormated(date));
    } else {
      accountStatementController.setToDate('');
    }
  }

  void setAccountStatementType(type) {
    resetAccountStatementFilterTypes();
    currentAccountStatementFilterType = type;
    accountStatementFilterTypesSelection[type] = true;
    if (type == 'بين تاريخين') {
      Get.bottomSheet(AccountStatementDatesBottomSheet());
    }
  }
}
