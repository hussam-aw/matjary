import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/PresentationLayer/Private/Order/delivery_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_basic_information.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/saving_order.dart';
import 'package:matjary/PresentationLayer/Private/Order/success_saving_order.dart';

class OrderScreenController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  RxBool finishSavingOrder = false.obs;

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

  void updateCurrentPageIndex(index) {
    currentIndex.value = index;
  }

  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return OrderBasicInformation();
      case 1:
        return OrderDetails();
      case 2:
        return DeliveryDetails();
      case 3:
        return SavingOrder();
    }
    return Container();
  }

  void goToPreviousPage() {
    if (currentIndex.value > 0 && currentIndex.value <= 3) {
      updateCurrentPageIndex(currentIndex.value - 1);
      pageController.previousPage(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300));
    } else {
      Get.back();
    }
  }

  void goToNextPage() {
    updateCurrentPageIndex(currentIndex.value + 1);
    pageController.animateToPage(currentIndex.value,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 300));
  }

  void goToSavingOrderPage() {
    updateCurrentPageIndex(4);
    finishSavingOrder.value = true;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
