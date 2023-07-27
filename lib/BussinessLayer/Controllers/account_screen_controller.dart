import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
