import 'package:get/get_state_manager/get_state_manager.dart';

class AccountScreenController extends GetxController {
  bool creditor = false;
  bool debtor = true;

  void setAccountType(type) {
    if (type == 'مدين') {
      creditor = false;
      debtor = true;
    } else {
      creditor = true;
      debtor = false;
    }
  }

  void changeAccountType(type) {
    setAccountType(type);
    update();
  }
}
