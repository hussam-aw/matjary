import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';

class OrdersController extends GetxController {
  OrdersRepo ordersRepo = OrdersRepo();
  var isLoadingOrders = true.obs;
  var isLoadingPurchaseOrder = true.obs;
  var isLoadingSaleOrders = true.obs;
  var isLoadingOrdersByType = false.obs;
  List<Order> orders = [];
  List<Order> purchasesOrders = [];
  List<Order> salesOrders = [];
  List<Order> currentOrders = [];
  List<Order> filteredOrders = [];
  String currentOrderFilterType = 'الكل';

  List<String> orderFilterTypes = [
    'الكل',
    'بيع للزبائن',
    'بيع مفرق',
    'مشتريات',
    'مردود بيع',
    'مردود شراء',
  ];

  Map<String, String> orderTypes = {
    'بيع للزبائن': 'sell_to_customers',
    'بيع مفرق': 'retail_sale',
    'مشتريات': 'purchases',
    'مردود بيع': 'sales_return',
    'مردود شراء': 'purchase_return',
  };

  RxMap<String, bool> orderFilterTypesSelection = {
    'الكل': true,
    'بيع للزبائن': false,
    'بيع مفرق': false,
    'مشتريات': false,
    'مردود بيع': false,
    'مردود شراء': false,
  }.obs;

  Map<String, String> counterOrderTypes = {
    'sell_to_customers': 'بيع للزبائن',
    'retail_sale': 'بيع مفرق',
    'purchases': 'مشتريات',
    "sales_return": 'مردود بيع',
    'purchase_return': 'مردود شراء',
  };

  Map<int, String> counterOrderStatus = {
    4: 'تامة',
    0: 'جاري التجهيز',
    1: 'تم التسديد',
    2: 'في شركة الشحن',
    3: 'قيد التوصيل',
  };

  Future<void> getOrders() async {
    isLoadingOrders.value = true;
    orders = await ordersRepo.getOrders();
    isLoadingOrders.value = false;
    filteredOrders = orders;
  }

  void getPurchasesOrders() {
    isLoadingPurchaseOrder.value = true;
    purchasesOrders =
        orders.where((order) => order.type == "purchases").toList();
    isLoadingPurchaseOrder.value = false;
  }

  void getSalesOrders() {
    isLoadingSaleOrders.value = true;
    salesOrders = orders
        .where((order) =>
            order.type == "sell_to_customers" || order.type == "retail_sale")
        .toList();
    isLoadingSaleOrders.value = false;
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
    currentOrderFilterType = type;
    orderFilterTypesSelection[type] = true;
  }

  Future<void> getOrdersByType(String type) async {
    isLoadingOrders.value = true;
    orders = await ordersRepo.getOrders();
    if (type == 'الكل') {
      currentOrders = orders;
    } else {
      currentOrders =
          orders.where((order) => order.type == orderTypes[type]).toList();
    }
    filteredOrders = currentOrders;
    isLoadingOrders.value = false;
  }

  List<Order> getOrdersForAccounts(accounts) {
    List<Order> orders = [];
    for (Account account in accounts) {
      for (Order order in currentOrders) {
        if (order.customerId == account.id) {
          orders.add(order);
        }
      }
    }
    return orders;
  }

  Future<void> getFilteredOrders(filter) async {
    isLoadingOrders.value = true;
    currentOrders = filteredOrders;
    var currentDate = DateTime.now();
    switch (filter) {
      case 'last_day':
        currentOrders = filteredOrders
            .where(
              (order) =>
                  currentDate.day == order.creationDate.day &&
                  currentDate.month == order.creationDate.month &&
                  currentDate.year == order.creationDate.year,
            )
            .toList();
        break;
      case 'last_week':
        var cuurrentWeekStart = currentDate.subtract(const Duration(days: 7));
        currentOrders = filteredOrders
            .where((order) =>
                order.creationDate.isAfter(cuurrentWeekStart) &&
                order.creationDate.isBefore(currentDate))
            .toList();
        break;
      case 'last_month':
        currentOrders = filteredOrders
            .where((order) =>
                currentDate.month == order.creationDate.month &&
                currentDate.year == order.creationDate.year)
            .toList();
        break;
    }
    isLoadingOrders.value = false;
    Get.back();
  }

  void setDefaultOrders(filterType) {
    if (filterType != null) {
      setOrderFilterType(filterType);
      getOrdersByType(filterType);
    } else {
      setOrderFilterType('الكل');
      getOrdersByType('الكل');
    }
  }
}
