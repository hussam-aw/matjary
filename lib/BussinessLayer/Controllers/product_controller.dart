import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController modelNumberController = TextEditingController();
  TextEditingController initialPriceController = TextEditingController();
  String affectedExchangeState = "يتأثر";
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController supplierPriceController = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  var homeController = Get.find<HomeController>();
  var loading = false.obs;

  String convertAffectedExchangeStateToString(int state) {
    if (state == 0) {
      return 'لا يتأثر';
    }
    return 'يتأثر';
  }

  void setProductDetails(Product? product) {
    if (product != null) {
      nameController = TextEditingController(text: product.name);
      modelNumberController =
          TextEditingController(text: product.specialNumber);
      initialPriceController =
          TextEditingController(text: product.initialPrice.toString());
      affectedExchangeState =
          convertAffectedExchangeStateToString(product.affectedExchange);
      wholesalePriceController =
          TextEditingController(text: product.wholesalePrice.toString());
      supplierPriceController =
          TextEditingController(text: product.supplierPrice.toString());
      retailPriceController =
          TextEditingController(text: product.retailPrice.toString());
    }
  }

  Future<void> deleteProduct(id) async {
    loading.value = true;
    var product = await prdouctsRepo.deleteProduct(id);
    loading.value = false;
    if (product != null) {
      homeController.getProducts();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
