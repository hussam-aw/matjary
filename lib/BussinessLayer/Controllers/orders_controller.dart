// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/Constants/app_strings.dart';
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
  List<Order> offlineOrders = [];
  String currentOrderFilterType = 'الكل';
  final connectivityController = Get.find<ConnectivityController>();
  DatabaseHelper databaseHelper = DatabaseHelper.db;

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
    orders = await ordersRepo.getOrders(connectivityController.isConnected);
    filteredOrders = orders;
    currentOrders = orders;
    getPurchasesOrders();
    getSalesOrders();
    backupOrders();
    isLoadingOrders.value = false;
  }

  Future<void> backupOrders() async {
    if (connectivityController.isConnected) {
      await databaseHelper.clearTable(ordersTableName);
      for (var order in orders) {
        await databaseHelper.insert(ordersTableName, order.toMap());
      }
    }
  }

  Future<void> syncOfflineOrders() async {
    offlineOrders = await ordersRepo.getOfflineOrders();
    bool isCreatedOrder;
    for (var order in offlineOrders) {
      isCreatedOrder = await ordersRepo.createOrder(
        true,
        order.customerId,
        order.total,
        order.notes,
        order.type,
        order.paidUp,
        order.restOfTheBill,
        order.wareId,
        order.toWareId,
        order.bankId,
        order.sellType,
        order.status,
        order.expenses,
        order.discount,
        order.marketerId,
        order.discountType,
        order.details,
        order.marketerFeeType,
        order.marketerFee,
        DateFormatter.getFormated(order.creationDate),
      );
    }
    await databaseHelper.clearTable(offlineOrderTableName);
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
    orders = await ordersRepo.getOrders(connectivityController.isConnected);
    print(orders);
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
