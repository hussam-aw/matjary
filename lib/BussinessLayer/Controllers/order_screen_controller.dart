import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  List<String> orderTypes = [
    'بيع للزبائن',
    'بيع مفرق',
    'مشتريات',
    'مردود بيع',
    'مردود شراء'
  ];

  RxMap<String, bool> orderTypesSelection = {
    'بيع للزبائن': true,
    'بيع مفرق': false,
    'مشتريات': false,
    'مردود بيع': false,
    'مردود شراء': false,
  }.obs;

  List<String> buyingTypes = [
    'مباشر',
    'توصيل',
    'شحن',
  ];

  RxMap<String, bool> buyingTypesSelection = {
    'مباشر': true,
    'توصيل': false,
    'شحن': false,
  }.obs;

  List<String> orderStatus = [
    'تامة',
    'جاري التجهيز',
    'تم التسديد',
    'في شركة الشحن',
    'قيد التوصيل',
  ];

  RxMap<String, bool> orderStatusSelection = {
    'تامة': true,
    'جاري التجهيز': false,
    'تم التسديد': false,
    'في شركة الشحن': false,
    'قيد التوصيل': false,
  }.obs;

  List<String> discountTypes = [
    'رقم',
    'نسبة',
  ];

  RxMap<String, bool> discountTypesSelection = {
    'رقم': true,
    'نسبة': false,
  }.obs;

  void resetOrderType() {
    orderTypesSelection.value = {
      'بيع للزبائن': false,
      'بيع مفرق': false,
      'مشتريات': false,
      'مردود بيع': false,
      'مردود شراء': false,
    };
  }

  void resetbuyingType() {
    buyingTypesSelection.value = {
      'مباشر': false,
      'توصيل': false,
      'شحن': false,
    };
  }

  void resetOrderStatus() {
    orderStatusSelection.value = {
      'تامة': false,
      'جاري التجهيز': false,
      'تم التسديد': false,
      'في شركة الشحن': false,
      'قيد التوصيل': false,
    };
  }

  void resetDiscountType() {
    discountTypesSelection.value = {
      'رقم': false,
      'نسبة': false,
    };
  }

  void setOrderType(type) {
    resetOrderType();
    orderTypesSelection[type] = true;
  }

  void setbuyingType(type) {
    resetbuyingType();
    buyingTypesSelection[type] = true;
  }

  void setOrderStatus(type) {
    resetOrderStatus();
    orderStatusSelection[type] = true;
  }

  void setDiscountType(type) {
    resetDiscountType();
    discountTypesSelection[type] = true;
  }

  // void changeOrderType(type) {
  //   setOrderType(type);
  //   update();
  // }

  // void changebuyingType(type) {
  //   setbuyingType(type);
  //   update();
  // }

  // void changeOrderStatus(type) {
  //   setOrderStatus(type);
  //   update();
  // }
}
