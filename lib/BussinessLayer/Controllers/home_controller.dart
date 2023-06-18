import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statements_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/payments_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/ware_repo.dart';
import 'package:matjary/main.dart';

class HomeController extends GetxController {
  //AccountsRepo accountsRepo = AccountsRepo();
  // WareRepo wareRepo = WareRepo();
  //OrdersRepo orderRepo = OrdersRepo();
  // PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  //var isLoading = false.obs;
  // List<Account> accounts = [];
  // var isLoadingAccounts = false.obs;
  // List<Account> bankAccounts = [];
  // var isLoadingBankAccounts = false.obs;
  // List<Account> clientAccounts = [];
  // var isLoadingClientAccounts = false.obs;
  // List<Ware> wares = [];
  // var isLoadingWares = false.obs;
  // List<Order> orders = [];
  // var isLoadingOrders = false.obs;
  // List<Order> purchasesOrders = [];
  // List<Order> salesOrders = [];
  // List<Product> products = [];
  // var isLoadingProducts = false.obs;
  List<Category> categories = [];
  var isLoadingCategories = false.obs;
  PaymentsRepo paymentsRepo = PaymentsRepo();
  AccountsController accountsController = Get.put(AccountsController());
  OrdersController ordersController = Get.put(OrdersController());
  WaresController waresController = Get.put(WaresController());
  ProductsController productsController = Get.put(ProductsController());
  PaymentsController paymentsController = Get.put(PaymentsController());
  // Future<void> getAccounts() async {
  //   isLoadingAccounts.value = true;
  //   accounts = await accountsRepo.getAccounts();
  //   isLoadingAccounts.value = false;
  // }

  // Future<void> getBankAccounts() async {
  //   isLoadingBankAccounts.value = true;
  //   bankAccounts = await accountsRepo.getBankAccounts();
  //   isLoadingBankAccounts.value = false;
  // }

  // Future<void> getClientAccounts() async {
  //   isLoadingClientAccounts.value = true;
  //   clientAccounts = accounts.where((account) => account.style == 2).toList();
  //   isLoadingClientAccounts.value = false;
  // }

  // Future<void> getWares() async {
  //   isLoadingWares.value = true;
  //   wares = await wareRepo.getWares();
  //   isLoadingWares.value = false;
  // }

  // Future<void> getOrders() async {
  //   isLoadingOrders.value = true;
  //   orders = await orderRepo.getOrders();
  //   isLoadingOrders.value = false;
  //   for (Order order in orders) {
  //     print(order.type);
  //   }
  //   getPurchasesOrders();
  //   getSalesOrders();
  // }

  // void getPurchasesOrders() {
  //   purchasesOrders =
  //       orders.where((order) => order.type == "purchases").toList();
  // }

  // void getSalesOrders() {
  //   salesOrders = orders
  //       .where((order) =>
  //           order.type == "sell_to_customers" || order.type == "retail_sale")
  //       .toList();
  // }

  // Future<void> getProducts() async {
  //   isLoadingProducts.value = true;
  //   products = await prdouctsRepo.getProducts();
  //   isLoadingProducts.value = false;
  // }

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    categories = await categoriesRepo.getCategories();
    isLoadingCategories.value = false;
  }

  void fetchData() async {
    //isLoading.value = true;
    ordersController.getOrders();
    accountsController.getCachAmount();
    await accountsController.getAccounts();
    accountsController.getClientAcoounts();
    accountsController.getBankAcoounts();
    productsController.getProducts();
    getCategories();
    paymentsController.getPayments();
    waresController.getWares();
    //isLoading.value = false;
  }

  @override
  void onInit() {
    fetchData();
    // getAccounts();
    // getBankAccounts();
    // getClientAccounts();
    // getWares();
    // getOrders();
    // getProducts();
    // getCategories();
    super.onInit();
  }
}
