import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class OrderController extends GetxController {
  OrdersRepo orderRepo = OrdersRepo();
  List<Order> orders = [];
  String? orderType = "";
  TextEditingController counterPartyController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController wareController = TextEditingController();
  TextEditingController marketerController = TextEditingController();
  Map<int, int> orderProductsQuantities = {};
  List<Product> selectedProducts = [];
  var loading = false.obs;
  HomeController homeController = Get.find<HomeController>();

  int convertOrderTypeToInt(String type) {
    switch (type) {
      case 'بيع للزبائن':
        return 0;
      case 'بيع مفرق':
        return 1;
      case 'مشتريات':
        return 2;
      case 'مردود بيع':
        return 3;
      case 'مردود شراء':
        return 4;
    }
    return 5;
  }

  void setCounterPartyAccount(accountName) {
    counterPartyController.value = TextEditingValue(text: accountName);
  }

  void setBankAccount(accountName) {
    bankController.value = TextEditingValue(text: accountName);
  }

  void setWare(wareName) {
    wareController.value = TextEditingValue(text: wareName);
  }

  void setMarketerAccount(accountName) {
    marketerController.value = TextEditingValue(text: accountName);
  }

  // Future<void> createOrder() async {
  //   if (true)
  //   // name.isNotEmpty &&
  //   {
  //     loading.value = true;
  //     var order = //await orderRepo.createOrder(id, total, notes, type, paidUp, restOfTheBill, wareId, toWareId, bankId, sellType, status, expenses, discount);
  //         loading.value = false;
  //     if (order != null) {
  //       homeController.getOrders();
  //       SnackBars.showSuccess('تم انشاء الطلب');
  //     } else {
  //       SnackBars.showError('فشل انشاء الطلب');
  //     }
  //   } else {
  //     SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
  //   }
  // }

  // Future<void> updateOrder(int id) async {
  //   loading.value = true;
  //   var order = //await orderRepo.updateOrder();
  //       loading.value = false;
  //   if (order != null) {
  //     homeController.getOrders();
  //     SnackBars.showSuccess('تم التعديل بنجاح');
  //   } else {
  //     SnackBars.showError('فشل التعديل');
  //   }
  // }

  // Future<void> deleteOrder(id) async {
  //   loading.value = true;
  //   var order = await orderRepo.deleteOrder(id);
  //   loading.value = false;
  //   if (order != null) {
  //     homeController.getOrders();
  //     SnackBars.showSuccess('تم الحذف بنجاح');
  //   } else {
  //     SnackBars.showError('فشل الحذف');
  //   }
  // }

  @override
  void onInit() {
    orderType = "بيع للزبائن";
    super.onInit();
  }
}
