import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earns_expenses_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/store_settings_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/users_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';

class HomeController extends GetxController {
  AccountsController accountsController = Get.put(AccountsController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  OrdersController ordersController = Get.put(OrdersController());
  WaresController waresController = Get.put(WaresController());
  ProductsController productsController = Get.put(ProductsController());
  PaymentsController paymentsController = Get.put(PaymentsController());
  EarnsExpensesController earnsExpensesController =
      Get.put(EarnsExpensesController());
  UsersController usersController = Get.put(UsersController());
  StoreSettingsController storeSettingsController =
      Get.put(StoreSettingsController());
  final connectivityController = Get.find<ConnectivityController>();

  void fetchData() async {
    await accountsController.getCachAmount();
    await accountsController.getAccounts();
    await ordersController.getOrders();
    storeSettingsController.getStoreSettings();
    productsController.getProducts();
    waresController.getWares();
    if (connectivityController.isConnected) {
      categoriesController.getCategories();
      paymentsController.getPayments();
      earnsExpensesController.getStatements();
      usersController.getUsers();
      await ordersController.syncOfflineOrders();
    }
  }

  @override
  void onInit() {
    connectivityController.connectivity.onConnectivityChanged.listen((event) {
      fetchData();
    });
    fetchData();
    super.onInit();
  }
}
