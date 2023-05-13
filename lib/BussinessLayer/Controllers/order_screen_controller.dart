import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/PresentationLayer/Private/Order/delivery_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_basic_information.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/saving_order.dart';
import 'package:matjary/PresentationLayer/Private/Order/success_saving_order.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class OrderScreenController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  String clinetOrSupplierName = '';
  String bankName = '';
  String wareName = '';
  String marketerName = '';
  TextEditingController productQuantityController = TextEditingController();
  RxList<Product> selectedProducts = <Product>[].obs;
  HomeController homeController = Get.find<HomeController>();
  OrderController orderController = Get.find<OrderController>();
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

  RxMap<int, int> selectedProductsQuantities = <int, int>{}.obs;

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
    if (checkIfOrderStepCompeleted(currentIndex.value)) {
      updateCurrentPageIndex(currentIndex.value + 1);
      pageController.animateToPage(currentIndex.value,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300));
    }
  }

  void goToSavingOrderPage() {
    updateCurrentPageIndex(4);
    finishSavingOrder.value = true;
  }

  bool checkIfProductQuantityIsZero(productId) {
    return selectedProductsQuantities.value[productId] == null ||
        selectedProductsQuantities.value[productId] == 0;
  }

  void increaseProductQuantity(productId) {
    selectedProductsQuantities[productId] =
        selectedProductsQuantities.value[productId] == null
            ? 1
            : selectedProductsQuantities.value[productId]! + 1;
  }

  void decreaseProductQuantity(productId) {
    if (selectedProductsQuantities.value[productId] != null &&
        selectedProductsQuantities.value[productId]! > 0) {
      selectedProductsQuantities[productId] =
          selectedProductsQuantities.value[productId]! - 1;
      if (selectedProductsQuantities.value[productId]! == 0) {
        selectedProductsQuantities.remove(productId);
      }
    }
  }

  void setProductQuantity(productId) {
    if (productQuantityController.text.isNotEmpty) {
      selectedProductsQuantities[productId] =
          int.parse(productQuantityController.text);

      productQuantityController.clear();
      Get.back();
    } else {
      SnackBars.showWarning('يرجى ادخال كمية المنتج');
    }
  }

  num calculateTotalProdcutPrice(price, quantity) {
    return num.parse(price) * quantity;
  }

  void getSelectedProducts() {
    if (selectedProductsQuantities.isNotEmpty) {
      for (Product product in homeController.products) {
        if (selectedProductsQuantities[product.id] != null) {
          selectedProducts.add(product);
        }
      }
      Get.back();
      SnackBars.showSuccess('تم اختيار المنتجات');
    } else {
      SnackBars.showWarning('يرجى اختيار المنتجات');
    }
  }

  void deleteSelectedProduct(productId) {
    selectedProductsQuantities.remove(productId);
    selectedProducts.removeWhere((product) => product.id == productId);
    SnackBars.showSuccess('تم ازالة المنتج');
  }

  void selectAccountBasedOnType(Account? account, type) {
    if (account != null) {
      if (type == "clientsAndSuppliers") {
        clinetOrSupplierName = account.name;
        orderController.setCounterPartyAccount(account.name);
      } else if (type == "bank") {
        bankName = account.name;
        orderController.setBankAccount(account.name);
      } else if (type == "marketer") {
        marketerName = account.name;
        orderController.setMarketerAccount(account.name);
      }
    }
  }

  void selectWare(Ware? ware) {
    if (ware != null) {
      wareName = ware.name;
      orderController.setWare(ware.name);
    }
  }

  bool checkIfOrderStepCompeleted(int stepIndex) {
    switch (stepIndex) {
      case 0:
        if (clinetOrSupplierName.isEmpty ||
            bankName.isEmpty ||
            wareName.isEmpty) {
          SnackBars.showWarning('يرجى اختيار الخانات المطلوبة');
          return false;
        }
        return true;
      case 1:
        if (selectedProducts.isEmpty) {
          SnackBars.showWarning('يرجى اختيار منتجات الفاتورة');
          return false;
        }
        return true;
    }
    return true;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
