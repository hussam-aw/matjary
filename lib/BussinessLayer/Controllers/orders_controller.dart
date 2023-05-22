import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';

class OrdersController extends GetxController {
  OrdersRepo ordersRepo = OrdersRepo();
  var isLoadingOrders = false.obs;
  List<Order> orders = [];
  List<Order> purchasesOrders = [];
  List<Order> salesOrders = [];

  List<String> orderFilterTypes = [
    'الكل',
    'بيع مفرق',
    'بيع للزبائن',
    'مشتريات',
    'مردود بيع',
    'مردود شراء'
  ];

  RxMap<String, bool> orderFilterTypesSelection = {
    'الكل': true,
    'بيع للزبائن': false,
    'بيع مفرق': false,
    'مشتريات': false,
    'مردود بيع': false,
    'مردود شراء': false,
  }.obs;

  Future<void> getOrders() async {
    isLoadingOrders.value = true;
    orders = await ordersRepo.getOrders();
    await getPurchasesOrders();
    await getSalesOrders();
    isLoadingOrders.value = false;
  }

  Future<void> getPurchasesOrders() async {
    purchasesOrders =
        orders.where((order) => order.type == "purchases").toList();
  }

  Future<void> getSalesOrders() async {
    salesOrders = orders
        .where((order) =>
            order.type == "sell_to_customers" || order.type == "retail_sale")
        .toList();
  }

  void resetOrderFilterTypes() {
    orderFilterTypesSelection.value = {
      'الكل': false,
      'بيع للزبائن': false,
      'بيع مفرق': false,
      'مشتريات': false,
      'مردود بيع': false,
      'مردود شراء': false,
    };
  }

  void setOrderFilterType(type) {
    resetOrderFilterTypes();
    orderFilterTypesSelection[type] = true;
  }
}
