import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class OrderController extends GetxController {
  OrdersRepo orderRepo = OrdersRepo();
  List<Order> orders = [];
  var loading = false.obs;
  HomeController homeController = Get.find<HomeController>();

  Future<void> createAccount() async {
    if (true)
    // name.isNotEmpty &&
    {
      loading.value = true;
      var order = //await orderRepo.createOrder(id, total, notes, type, paidUp, restOfTheBill, wareId, toWareId, bankId, sellType, status, expenses, discount);
          loading.value = false;
      if (order != null) {
        homeController.getOrders();
        SnackBars.showSuccess('تم انشاء الطلب');
      } else {
        SnackBars.showError('فشل انشاء الطلب');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateOrder(int id) async {
    loading.value = true;
    var order = //await orderRepo.updateOrder();
        loading.value = false;
    if (order != null) {
      homeController.getOrders();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteOrder(id) async {
    loading.value = true;
    var order = await orderRepo.deleteOrder(id);
    loading.value = false;
    if (order != null) {
      homeController.getOrders();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
