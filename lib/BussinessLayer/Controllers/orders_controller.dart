import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';

class OrdersController extends GetxController {
  OrdersRepo ordersRepo = OrdersRepo();
  var isLoadingOrders = false.obs;
  var isLoadingOrdersByType = false.obs;
  List<Order> orders = [];
  List<Order> purchasesOrders = [];
  List<Order> salesOrders = [];
  List<Order> currentOrders = [];
  List<Order> filteredOrders = [];
  String currentOrderFilterType = 'الكل';

  List<String> orderFilterTypes = [
    'الكل',
    'بيع مفرق',
    'بيع للزبائن',
    'مشتريات',
    'مردود بيع',
    'مردود شراء'
  ];

  Map<String, String> counterOrderTypes = {
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

  Future<void> getOrders() async {
    isLoadingOrders.value = true;
    orders = await ordersRepo.getOrders();
    await getPurchasesOrders();
    await getSalesOrders();
    isLoadingOrders.value = false;
    filteredOrders = orders;
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
    currentOrderFilterType = type;
    orderFilterTypesSelection[type] = true;
  }

  Future<void> getOrdersByType(String type) async {
    isLoadingOrders.value = true;
    orders = await ordersRepo.getOrders();
    if (type == 'الكل') {
      currentOrders = orders;
    } else {
      currentOrders = orders
          .where((order) => order.type == counterOrderTypes[type])
          .toList();
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
}
