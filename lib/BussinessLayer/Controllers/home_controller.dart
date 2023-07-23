import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earns_expenses_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/payments_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class HomeController extends GetxController {
  //AccountsRepo accountsRepo = AccountsRepo();
  // WareRepo wareRepo = WareRepo();
  //OrdersRepo orderRepo = OrdersRepo();
  // PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  // CategoriesRepo categoriesRepo = CategoriesRepo();
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
  // List<Category> categories = [];
  // var isLoadingCategories = false.obs;
  PaymentsRepo paymentsRepo = PaymentsRepo();
  AccountsController accountsController = Get.put(AccountsController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  OrdersController ordersController = Get.put(OrdersController());
  WaresController waresController = Get.put(WaresController());
  ProductsController productsController = Get.put(ProductsController());
  PaymentsController paymentsController = Get.put(PaymentsController());
  EarnsExpensesController earnsExpensesController =
      Get.put(EarnsExpensesController());
  BoxClient boxClient = BoxClient();
  List<Account> pinnedAccounts = [];
  var isLoading = true.obs;
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

  // Future<void> getCategories() async {
  //   isLoadingCategories.value = true;
  //   categories = await categoriesRepo.getCategories();
  //   isLoadingCategories.value = false;
  // }

  Future<void> pinAccountToHomeScreen(accountId) async {
    await boxClient.setAccountToPinnedAccountList(accountId);
    await getPinnedAccounts();
    SnackBars.showSuccess('تم تثبيت الحساب في الشاشة الرئيسية');
  }

  Future<void> getPinnedAccounts() async {
    isLoading.value = true;
    var accountIds = await boxClient.getPinnedAccountsList();
    if (accountIds != null) {
      pinnedAccounts = accountIds
          .map((id) => accountsController.getAccountFromId(id)!)
          .toList();
    } else {
      pinnedAccounts = accountsController.customersAccounts;
    }
    isLoading.value = false;
  }

  void fetchData() async {
    //isLoading.value = true;
    ordersController.getOrders();
    await accountsController.getAccounts();
    await getPinnedAccounts();
    productsController.getProducts();
    categoriesController.getCategories();
    paymentsController.getPayments();
    waresController.getWares();
    earnsExpensesController.getStatements();
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
