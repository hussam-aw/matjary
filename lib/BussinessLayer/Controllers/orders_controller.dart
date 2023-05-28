import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
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
  List<Order> filteredOrder = [];
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
    isLoadingOrders.value = false;
  }

  List<Order> getOrdersForAccounts(accounts) {
    filteredOrder = [];
    for (Account account in accounts) {
      for (Order order in currentOrders) {
        if (order.customerId == account.id) {
          filteredOrder.add(order);
        }
      }
    }
    return filteredOrder;
  }
}
