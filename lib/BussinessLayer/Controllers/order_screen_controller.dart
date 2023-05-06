import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  List<String> orderTypes = [
    'بيع للزبائن',
    'بيع مفرق',
    'مشتريات',
    'مردود بيع',
    'مردود شراء'
  ];

  Map<String, bool> orderSelection = {
    'بيع للزبائن': true,
    'بيع مفرق': false,
    'مشتريات': false,
    'مردود بيع': false,
    'مردود شراء': false,
  };

  void resetOrderType() {
    orderSelection = {
      'بيع للزبائن': false,
      'بيع مفرق': false,
      'مشتريات': false,
      'مردود بيع': false,
      'مردود شراء': false,
    };
  }

  void setOrderType(type) {
    resetOrderType();
    orderSelection[type] = true;
  }

  void changeOrderType(type) {
    setOrderType(type);
    update();
  }
}
