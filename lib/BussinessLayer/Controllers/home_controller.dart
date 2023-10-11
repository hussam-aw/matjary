import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earns_expenses_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statements_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/store_settings_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/user_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/users_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/main.dart';

class HomeController extends GetxController {
  AccountsController accountsController = Get.put(AccountsController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  OrdersController ordersController = Get.put(OrdersController());
  WaresController waresController = Get.put(WaresController());
  ProductsController productsController = Get.put(ProductsController());
  StatementsController statementsController = Get.put(StatementsController());
  PaymentsController paymentsController = Get.put(PaymentsController());
  EarnsExpensesController earnsExpensesController =
      Get.put(EarnsExpensesController());
  UsersController usersController = Get.put(UsersController());
  StoreSettingsController storeSettingsController =
      Get.put(StoreSettingsController());
  UserController userController = Get.put(UserController());
  ConnectivityController connectivityController =
      Get.find<ConnectivityController>();

  void fetchData() async {
    await accountsController.getCachAmount();
    await ordersController.getOrders();
    await accountsController.getAccounts();
    storeSettingsController.getStoreSettings();
    if (connectivityController.isConnected) {
      await ordersController.syncOfflineOrders();
      await paymentsController.syncOfflinePayments();
      await statementsController.syncOfflineStatements();
      await earnsExpensesController.syncOfflineEarnsAndExpenses();
      earnsExpensesController.getEarnsAndExpenses();
      paymentsController.getPayments();
      categoriesController.getCategories();
      userController.updateUserData(MyApp.appUser!.id);
      usersController.getUsers();
    }
    productsController.getProducts();
    waresController.getWares();
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
