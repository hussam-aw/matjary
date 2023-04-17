import 'package:get/get_state_manager/get_state_manager.dart';

class AccountScreenController extends GetxController {
  bool creditor = false;
  bool debtor = true;
  void changeAccountType(type) {
    if (type == 0) {
      creditor = false;
      debtor = true;
    } else {
      creditor = true;
      debtor = false;
    }
    update();
  }
}
