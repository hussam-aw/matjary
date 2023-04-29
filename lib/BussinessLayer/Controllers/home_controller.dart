import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/ware_repo.dart';

class HomeController extends GetxController {
  AccountsRepo accountsRepo = AccountsRepo();
  WareRepo wareRepo = WareRepo();
  OrdersRepo orderRepo = OrdersRepo();
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  var isLoading = false.obs;
  List<Account> accounts = [];
  var isLoadingAccounts = false.obs;
  List<Account> bankAccounts = [];
  List<Account> clientAccounts = [];
  List<Ware> wares = [];
  var isLoadingWares = false.obs;
  List<Order> orders = [];
  var isLoadingOrders = false.obs;
  List<Order> purchasesOrders = [];
  List<Order> salesOrders = [];
  List<Product> products = [];
  var isLoadingProducts = false.obs;
  List<Category> categories = [];
  var isLoadingCategories = false.obs;

  Future<void> getAccounts() async {
    isLoadingAccounts.value = true;
    accounts = await accountsRepo.getAccounts();
    isLoadingAccounts.value = false;
    getBankAccounts();
    getClientAccounts();
  }

  void getBankAccounts() {
    bankAccounts = accounts.where((account) => account.type == 0).toList();
  }

  void getClientAccounts() {
    clientAccounts = accounts.where((account) => account.type == 1).toList();
  }

  // Future<void> getBankAccounts() async {
  //   bankAccounts = await accountsRepo.getBankAccounts();
  // }

  // Future<void> getClientAccounts() async {
  //   clientAccounts = await accountsRepo.getClientAccounts();
  // }

  Future<void> getWares() async {
    isLoadingWares.value = true;
    wares = await wareRepo.getWares();
    isLoadingWares.value = false;
  }

  Future<void> getOrders() async {
    isLoadingOrders.value = true;
    orders = await orderRepo.getOrders();
    isLoadingOrders.value = false;
    getPurchasesOrders();
    getSalesOrders();
  }

  void getPurchasesOrders() {
    purchasesOrders = orders.where((order) => order.type == "0").toList();
  }

  void getSalesOrders() {
    salesOrders = orders.where((order) => order.type == "1").toList();
  }

  Future<void> getProducts() async {
    isLoadingProducts.value = true;
    products = await prdouctsRepo.getProducts();
    isLoadingProducts.value = false;
  }

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    categories = await categoriesRepo.getCategories();
    isLoadingCategories.value = false;
  }

  void fetchData() async {
    isLoading.value = true;
    await getAccounts();
    await getWares();
    await getOrders();
    await getProducts();
    await getCategories();
    isLoading.value = false;
    update();
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
