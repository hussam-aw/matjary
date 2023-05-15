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
  String selectedOrderType = 'بيع للزبائن';
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
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

  List<String> discountOrderTypes = [
    'رقم',
    'نسبة',
  ];

  RxMap<String, bool> discountOrderTypesSelection = {
    'رقم': true,
    'نسبة': false,
  }.obs;

  RxMap<String, bool> marketerDiscountSelection = {
    'رقم': true,
    'نسبة': false,
  }.obs;

  RxMap<int, int> selectedProductsQuantities = <int, int>{}.obs;
  RxMap<int, num> selectedProductPrices = <int, num>{}.obs;

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
    discountOrderTypesSelection.value = {
      'رقم': false,
      'نسبة': false,
    };
  }

  void resetMarketerDiscount() {
    marketerDiscountSelection.value = {
      'رقم': false,
      'نسبة': false,
    };
  }

  void setOrderType(type) {
    resetOrderType();
    selectedOrderType = type;
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
    discountOrderTypesSelection[type] = true;
    orderController.discountOrderController.clear();
  }

  void setMarketerDiscount(type) {
    resetMarketerDiscount();
    marketerDiscountSelection[type] = true;
    orderController.marketerDiscountController.clear();
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
      case 4:
        return SuccessSavingOrder();
    }
    return Container();
  }

  void goToPreviousPage() {
    if (currentIndex.value > 0 && currentIndex.value <= 3) {
      updateCurrentPageIndex(currentIndex.value - 1);
      animateToPage(currentIndex.value);
    } else {
      Get.back();
    }
  }

  void goToNextPage() {
    if (checkIfOrderStepCompeleted(currentIndex.value)) {
      updateCurrentPageIndex(currentIndex.value + 1);
      animateToPage(currentIndex.value);
    }
  }

  void goToInitialPage() {
    updateCurrentPageIndex(0);
    animateToPage(currentIndex.value);
  }

  void animateToPage(index) {
    pageController.animateToPage(index,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 300));
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
    } else {
      SnackBars.showWarning('يرجى ادخال الكمية');
    }
  }

  void setProductPrice(productId) {
    if (productPriceController.text.isNotEmpty) {
      selectedProductPrices[productId] = num.parse(productPriceController.text);
      productPriceController.clear();
    } else {
      SnackBars.showWarning('يرجى ادخال السعر');
    }
  }

  num calculateTotalProdcutPrice(price, quantity) {
    return price * quantity;
  }

  void getSelectedProducts() {
    if (selectedProductsQuantities.isNotEmpty) {
      for (Product product in homeController.products) {
        if (selectedProductsQuantities[product.id] != null) {
          selectedProducts.add(product);
          selectedProductPrices[product.id] =
              getProductPricrBasedOnOrderType(product);
        }
      }
      Get.back();
      SnackBars.showSuccess('تم اختيار المنتجات');
    } else {
      SnackBars.showWarning('يرجى اختيار المنتجات');
    }
  }

  void updateSelectedProductsPrices() {
    for (Product product in selectedProducts) {
      selectedProductPrices[product.id] =
          getProductPricrBasedOnOrderType(product);
    }
  }

  num getProductPricrBasedOnOrderType(Product product) {
    if (selectedOrderType == 'بيع مفرق') {
      return num.parse(product.retailPrice);
    } else if (selectedOrderType == 'بيع للزبائن') {
      return num.parse(product.supplierPrice);
    }
    return 0.0;
  }

  void deleteSelectedProduct(productId) {
    selectedProductsQuantities.remove(productId);
    selectedProducts.removeWhere((product) => product.id == productId);
    setProductsQuantities();
    setSelectedProducts();
    orderController.refreshOrderCalculations();
    SnackBars.showSuccess('تم ازالة المنتج');
  }

  void setProductsQuantities() {
    orderController.setProductsQuantities(selectedProductsQuantities.value);
    orderController.refreshOrderCalculations();
  }

  void setProductsPrices() {
    orderController.setProductsPrices(selectedProductPrices.value);
    orderController.refreshOrderCalculations();
  }

  void setSelectedProducts() {
    orderController.setSelectedProducts(selectedProducts);
  }

  void setOrderProducts() {
    orderController.setSelectedProducts(selectedProducts);
    orderController.setProductsQuantities(selectedProductsQuantities.value);
    orderController.setProductsPrices(selectedProductPrices.value);
    orderController.refreshOrderCalculations();
  }

  void selectAccountBasedOnType(Account? account, type) {
    if (account != null) {
      if (type == "clientsAndSuppliers") {
        orderController.setCounterPartyAccount(account.name);
      } else if (type == "bank") {
        orderController.setBankAccount(account.name);
      } else if (type == "marketer") {
        orderController.setMarketerAccount(account.name);
      }
    }
  }

  void selectWare(Ware? ware) {
    if (ware != null) {
      orderController.setWare(ware.name);
    }
  }

  bool checkIfOrderStepCompeleted(int stepIndex) {
    switch (stepIndex) {
      case 0:
        if (orderController.counterPartyController.text.isEmpty ||
            orderController.bankController.text.isEmpty ||
            orderController.wareController.text.isEmpty) {
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
      case 2:
        if (orderController.expensesController.text.isEmpty ||
            orderController.discountOrderController.text.isEmpty) {
          SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
          return false;
        }
        return true;
      case 3:
        if (orderController.paidAmountController.text.isEmpty) {
          SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
          return false;
        }
        return true;
    }
    return true;
  }

  void resetOrderScreen() {
    goToInitialPage();
    selectedOrderType = 'بيع للزبائن';
    setOrderType(orderTypes[0]);
    setbuyingType(buyingTypes[0]);
    setOrderStatus(orderStatus[0]);
    setDiscountType(discountOrderTypes[0]);
    setMarketerDiscount(discountOrderTypes[0]);
    productQuantityController.value = const TextEditingValue();
    productPriceController.value = const TextEditingValue();
    selectedProducts = <Product>[].obs;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
