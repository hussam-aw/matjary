import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/image_picker_helper.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';

class AccountScreenController extends GetxController {
  bool accountStyleForInformation = false;
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  RxString selectedAccountImage = ''.obs;

  List<String> accountTypes = [
    'مدين',
    'دائن',
  ];

  Map<int, String> counterAccountTypes = {
    0: 'مدين',
    1: 'دائن',
  };

  Map<int, String> counterAccountStyles = {
    1: 'صندوق',
    2: 'زبون',
    3: 'مورد',
    4: 'جهة عمل',
    6: 'حساب عادي',
    10: 'مسوق',
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

  bool checkAccountStyleForInformation(style) {
    switch (style) {
      case 'حساب عادي':
        return false;
      case 'صندوق':
        return false;
      default:
        return true;
    }
  }

  void setAccountStyleForInformation(style) {
    accountStyleForInformation = checkAccountStyleForInformation(style);
  }

  void changeAccountStyleForInformation(style) {
    setAccountStyleForInformation(style);
    update();
  }

  void selectAccountImage() async {
    selectedAccountImage.value = await imagePickerHelper.pickImage();
  }

  void setAcountDetails(Account? account) {
    if (account != null) {
      setAccountType(counterAccountTypes[account.type]);
      setAccountStyleForInformation(counterAccountStyles[account.style]);
    } else {
      setAccountType('مدين');
      setAccountStyleForInformation('حساب عادي');
    }
  }
}
