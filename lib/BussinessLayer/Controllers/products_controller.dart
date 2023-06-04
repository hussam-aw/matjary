import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';

class ProductsController extends GetxController {
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  List<Product> products = [];
  var isLoadingProducts = false.obs;

  Future<void> getProducts() async {
    isLoadingProducts.value = true;
    products = await prdouctsRepo.getProducts();
    isLoadingProducts.value = false;
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
