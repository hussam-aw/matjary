import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  bool affected = false;
  bool notAffected = true;

  void setAffectedExchangeState(type) {
    if (type == 'يتأثر') {
      affected = true;
      notAffected = false;
    } else {
      affected = false;
      notAffected = true;
    }
  }

  void changeAffectedExchangeState(type) {
    setAffectedExchangeState(type);
    update();
  }
}
