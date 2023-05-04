import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/helpers/image_picker_helper.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController modelNumberController = TextEditingController();
  TextEditingController initialPriceController = TextEditingController();
  String? category;
  TextEditingController quantityController = TextEditingController();
  String? affectedExchangeState;
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController supplierPriceController = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  List<XFile> imageFiles = [];
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  var homeController = Get.find<HomeController>();
  var loading = false.obs;

  String convertAffectedExchangeStateToString(int state) {
    if (state == 0) {
      return 'لا يتأثر';
    }
    return 'يتأثر';
  }

  int convertAffectedExchangeStateToInt(String state) {
    if (state == 'لا يتأثر') {
      return 0;
    }
    return 1;
  }

  int getCategoryId(categoryName) {
    return homeController.categories
        .firstWhere((category) => category.name == categoryName)
        .id;
  }

  void selectImages() async {
    imageFiles = await imagePickerHelper.pickImages();
  }

  void setProductDetails(Product? product) {
    if (product != null) {
      nameController = TextEditingController(text: product.name);
      modelNumberController =
          TextEditingController(text: product.specialNumber);
      initialPriceController =
          TextEditingController(text: product.initialPrice.toString());
      category = product.category;
      quantityController =
          TextEditingController(text: product.quantity.toString());
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

  Future<void> createProduct() async {
    String name = nameController.text;
    String specialNumber = modelNumberController.text;
    String quantity = quantityController.text;
    String wholesalePrice = wholesalePriceController.text;
    String supplierPrice = supplierPriceController.text;
    String retailPrice = retailPriceController.text;
    if (name.isNotEmpty &&
        specialNumber.isNotEmpty &&
        quantity.isNotEmpty &&
        wholesalePrice.isNotEmpty &&
        supplierPrice.isNotEmpty &&
        retailPrice.isNotEmpty) {
      loading.value = true;
      var product = await prdouctsRepo.createProduct(
        name,
        getCategoryId(category),
        specialNumber,
        num.parse(wholesalePrice),
        num.parse(retailPrice),
        num.parse(supplierPrice),
        int.parse(quantity),
        convertAffectedExchangeStateToInt(affectedExchangeState!),
        20,
        MyApp.appUser!.id,
        [],
      );
      loading.value = false;
      if (product != null) {
        homeController.getProducts();
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
    String quantity = quantityController.text;
    String wholesalePrice = wholesalePriceController.text;
    String supplierPrice = supplierPriceController.text;
    String retailPrice = retailPriceController.text;
    loading.value = true;
    var product = await prdouctsRepo.updateProduct(
      id,
      name,
      getCategoryId(category),
      specialNumber,
      num.parse(wholesalePrice),
      num.parse(retailPrice),
      num.parse(supplierPrice),
      int.parse(quantity),
      convertAffectedExchangeStateToInt(affectedExchangeState!),
      20,
      MyApp.appUser!.id,
      [],
    );
    loading.value = false;
    if (product != null) {
      homeController.getProducts();
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
      homeController.getProducts();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }

  @override
  void onInit() {
    category = homeController.categories[0].name;
    affectedExchangeState = "يتأثر";
    super.onInit();
  }
}
