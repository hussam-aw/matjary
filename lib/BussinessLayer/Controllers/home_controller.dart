import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/accounts_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/DataAccesslayer/Repositories/ware_repo.dart';

class HomeController extends GetxController {
  AccountsRepo accountsRepo = AccountsRepo();
  WareRepo wareRepo = WareRepo();
  OrdersRepo orderRepo = OrdersRepo();
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  List<Account> accounts = [];
  List<Account> bankAccounts = [];
  List<Account> clientAccounts = [];
  List<Ware> wares = [];
  List<Order> orders = [];
  List<Product> products = [];
  var isLoadingAccounts = false.obs;

  Future<void> getAccounts() async {
    accounts = await accountsRepo.getAccounts();
    update();
  }

  Future<void> getBankAccounts() async {
    isLoadingAccounts.value = true;
    bankAccounts = await accountsRepo.getBankAccounts();
    isLoadingAccounts.value = false;
  }

  Future<void> getClintAccounts() async {
    isLoadingAccounts.value = true;
    clientAccounts = await accountsRepo.getClientAccounts();
    isLoadingAccounts.value = false;
  }

  Future<void> getWares() async {
    wares = await wareRepo.getWares();
    update();
  }

  Future<void> getOrders() async {
    orders = await orderRepo.getOrders();
    update();
  }

  Future<void> getProducts() async {
    products = await prdouctsRepo.getProducts();
    update();
  }

  @override
  void onInit() {
    getAccounts();
    getBankAccounts();
    getClintAccounts();
    getWares();
    getOrders();
    getProducts();
    super.onInit();
  }
}
