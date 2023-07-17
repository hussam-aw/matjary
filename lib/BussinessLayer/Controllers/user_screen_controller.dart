import 'package:get/get.dart';

class UserScreenController extends GetxController {
  List<String> userTypes = [
    'مسؤول',
    'محرر',
  ];

  RxMap<String, bool> userTypesSelection = {
    'مسؤول': true,
    'محرر': false,
  }.obs;

  void resetUserTypes() {
    userTypesSelection.value = {
      'مسؤول': false,
      'محرر': false,
    };
  }

  void setUserType(type) {
    if (type != null) {
      resetUserTypes();
      userTypesSelection[type] = true;
    }
  }

  List<String> notifiableTypes = [
    'استلام اشعارات',
    'بدون اشعارات',
  ];

  RxMap<String, bool> notifiableTypesSelection = {
    'استلام اشعارات': true,
    'بدون اشعارات': false,
  }.obs;

  void resetNotifiableTypes() {
    notifiableTypesSelection.value = {
      'استلام اشعارات': false,
      'بدون اشعارات': false,
    };
  }

  void setNotifiableType(type) {
    if (type != null) {
      resetNotifiableTypes();
      notifiableTypesSelection[type] = true;
    }
  }
}
