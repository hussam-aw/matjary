import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';

class ProductsController extends GetxController {
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  List<Product> products = [];
  var isLoadingProducts = false.obs;
  final connectivityController = Get.find<ConnectivityController>();
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<void> getProducts() async {
    isLoadingProducts.value = true;
    products =
        await prdouctsRepo.getProducts(connectivityController.isConnected);
    backupProducts();
    isLoadingProducts.value = false;
  }

  Future<void> backupProducts() async {
    databaseHelper.clearTable(productsTableName);
    if (connectivityController.isConnected) {
      for (var product in products) {
        await databaseHelper.insert(productsTableName, product.toMap());
      }
    }
  }

  Product? getProductFromId(productId) {
    var product =
        products.firstWhereOrNull((product) => product.id == productId);
    if (product != null) {
      return product;
    }
    return null;
  }

  String getProductName(int? id) {
    return getProductFromId(id) != null ? getProductFromId(id)!.name : '';
  }
}
