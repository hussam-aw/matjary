import 'package:get/get.dart';

class AccountScreenController extends GetxController {
  List<String> accountTypes = [
    'مدين',
    'دائن',
  ];

  Map<int, String> counterAccountTypes = {
    0: 'مدين',
    1: 'دائن',
  };

  RxMap<String, bool> accountTypesSelection = {
    'مدين': true,
    'دائن': false,
  }.obs;

  void resetAccountTypes() {
    accountTypesSelection.value = {
      'مدين': false,
      'دائن': false,
    };
  }

  void setAccountType(type) {
    if (type != null) {
      resetAccountTypes();
      accountTypesSelection[type] = true;
    }
  }
}
