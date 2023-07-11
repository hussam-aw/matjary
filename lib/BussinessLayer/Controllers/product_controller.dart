import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController initialPriceController = TextEditingController();

  TextEditingController categoryNameController = TextEditingController();
  int? categoryId;
  TextEditingController quantityController = TextEditingController();

  String? affectedExchangeState;
  TextEditingController retailPriceController = TextEditingController();

  TextEditingController supplierPriceController = TextEditingController();

  TextEditingController wholesalePriceController = TextEditingController();

  List<String> imagePaths = [];
  List<String> selectedImages = [];
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  var categoriesController = Get.find<CategoriesController>();
  ProductsController productsController = Get.find<ProductsController>();
  var loading = false.obs;

  void setCategory(cat) {
    if (cat != null) {
      categoryId = cat.id;
      categoryNameController.value = TextEditingValue(
          text: categoriesController.getCategoryName(categoryId));
    } else {
      categoryId = null;
      categoryNameController.value = const TextEditingValue(text: 'غير مصنف');
    }
  }

  String convertAffectedExchangeStateToString(String state) {
    if (state == "0") {
      return 'لا يتأثر';
    }
    return 'يتأثر';
  }

  String convertAffectedExchangeStateToInt(String state) {
    if (state == 'لا يتأثر') {
      return "0";
    }
    return "1";
  }

  num getInitialPrice() {
    return initialPriceController.text.isEmpty
        ? 0
        : num.parse(initialPriceController.text);
  }

  int getQuantity() {
    return quantityController.text.isEmpty
        ? 0
        : int.parse(quantityController.text);
  }

  num getWholesalePrice() {
    return wholesalePriceController.text.isEmpty
        ? 0
        : num.parse(wholesalePriceController.text);
  }

  num getRetailPrice() {
    return retailPriceController.text.isEmpty
        ? 0
        : num.parse(retailPriceController.text);
  }

  num getSupplierPrice() {
    return supplierPriceController.text.isEmpty
        ? 0
        : num.parse(supplierPriceController.text);
  }

  void setImages(images) {
    selectedImages = images;
  }

  void setProductDetails(Product? product) {
    if (product != null) {
      nameController = TextEditingController(text: product.name);

      initialPriceController =
          TextEditingController(text: product.initialPrice.toString());
      setCategory(categoriesController.getCategoryFromId(product.categoryId));
      quantityController =
          TextEditingController(text: product.quantity.toString());
      affectedExchangeState = convertAffectedExchangeStateToString(
          product.affectedExchange.toString());
      wholesalePriceController =
          TextEditingController(text: product.wholesalePrice.toString());
      supplierPriceController =
          TextEditingController(text: product.supplierPrice.toString());
      retailPriceController =
          TextEditingController(text: product.retailPrice.toString());
      imagePaths = product.images;
    }
  }

  Future<void> createProduct() async {
    String name = nameController.text;
    num initialPrice = getInitialPrice();
    int quantity = getQuantity();
    num wholesalePrice = getWholesalePrice();
    num supplierPrice = getSupplierPrice();
    num retailPrice = getRetailPrice();
    if (name.isNotEmpty) {
      loading.value = true;

      var product = await prdouctsRepo.createProduct(
        name,
        categoryId,
        wholesalePrice,
        retailPrice,
        supplierPrice,
        quantity,
        convertAffectedExchangeStateToInt(affectedExchangeState!),
        initialPrice,
        MyApp.appUser!.id,
        selectedImages.isEmpty ? [] : selectedImages,
      );
      loading.value = false;
      if (product != null) {
        productsController.getProducts();
        SnackBars.showSuccess('تم انشاء المنتج');
      } else {
        SnackBars.showError('فشل انشاء المنتج');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateProduct(int id) async {
    String name = nameController.text;
    num initialPrice = getInitialPrice();
    int quantity = getQuantity();
    num wholesalePrice = getWholesalePrice();
    num supplierPrice = getSupplierPrice();
    num retailPrice = getRetailPrice();

    loading.value = true;
    var product = await prdouctsRepo.updateProduct(
      id,
      name,
      categoryId,
      wholesalePrice,
      retailPrice,
      supplierPrice,
      quantity,
      convertAffectedExchangeStateToInt(affectedExchangeState!),
      initialPrice,
      MyApp.appUser!.id,
      selectedImages.isEmpty ? [] : selectedImages,
    );
    loading.value = false;
    if (product != null) {
      productsController.getProducts();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteProduct(id) async {
    loading.value = true;
    var product = await prdouctsRepo.deleteProduct(id);
    loading.value = false;
    if (product != null) {
      productsController.getProducts();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }

  @override
  void onInit() {
    categoryId = null;
    affectedExchangeState = "يتأثر";
    selectedImages.clear();
    super.onInit();
  }
}
