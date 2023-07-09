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
  TextEditingController modelNumberController = TextEditingController();
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

  void setImages(images) {
    selectedImages = images;
  }

  void setProductDetails(Product? product) {
    if (product != null) {
      nameController = TextEditingController(text: product.name);
      modelNumberController =
          TextEditingController(text: product.specialNumber);
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
    String specialNumber = modelNumberController.text;
    String initialPrice = initialPriceController.text;
    String quantity = quantityController.text;
    String wholesalePrice = wholesalePriceController.text;
    String supplierPrice = supplierPriceController.text;
    String retailPrice = retailPriceController.text;
    if (name.isNotEmpty &&
        specialNumber.isNotEmpty &&
        initialPrice.isNotEmpty &&
        quantity.isNotEmpty &&
        wholesalePrice.isNotEmpty &&
        supplierPrice.isNotEmpty &&
        retailPrice.isNotEmpty) {
      loading.value = true;

      var product = await prdouctsRepo.createProduct(
        name,
        categoryId,
        specialNumber,
        num.parse(wholesalePrice),
        num.parse(retailPrice),
        num.parse(supplierPrice),
        int.parse(quantity),
        convertAffectedExchangeStateToInt(affectedExchangeState!),
        num.parse(initialPrice),
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
    String specialNumber = modelNumberController.text;
    String initialPrice = initialPriceController.text;
    String quantity = quantityController.text;
    String wholesalePrice = wholesalePriceController.text;
    String supplierPrice = supplierPriceController.text;
    String retailPrice = retailPriceController.text;

    loading.value = true;
    var product = await prdouctsRepo.updateProduct(
      id,
      name,
      categoryId,
      specialNumber,
      num.parse(wholesalePrice),
      num.parse(retailPrice),
      num.parse(supplierPrice),
      int.parse(quantity),
      convertAffectedExchangeStateToInt(affectedExchangeState!),
      num.parse(initialPrice),
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
