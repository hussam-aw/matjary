import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Repositories/products_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  Category? category;
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? affectedExchangeState;
  TextEditingController retailPriceController = TextEditingController();
  TextEditingController supplierPriceController = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  List<String> productImages = [];
  PrdouctsRepo prdouctsRepo = PrdouctsRepo();
  var categoriesController = Get.find<CategoriesController>();
  ProductsController productsController = Get.find<ProductsController>();
  var loading = false.obs;
  var savingState = false;

  String convertToCounterAffectedExchangeState(String state) {
    if (state == "0") {
      return 'لا يتأثر';
    }
    return 'يتأثر';
  }

  String convertToAffectedExchangeState(String state) {
    if (state == 'لا يتأثر') {
      return "0";
    }
    return "1";
  }

  void setProductName(name) {
    if (name.isNotEmpty) {
      nameController.value = TextEditingValue(text: name);
    } else {
      nameController.clear();
    }
  }

  String getProductName() {
    return nameController.text;
  }

  void setCategory(cat) {
    if (cat != null) {
      category = cat;
      categoryNameController.value = TextEditingValue(
          text: categoriesController.getCategoryName(category!.id));
    } else {
      category = null;
      categoryNameController.value = const TextEditingValue(text: 'غير مصنف');
    }
  }

  int? getCategoryId() {
    return category != null ? category!.id : null;
  }

  void setProductPrice(price) {
    if (price.isNotEmpty) {
      priceController.value = TextEditingValue(text: price);
    } else {
      priceController.clear();
    }
  }

  num getProductPrice() {
    return priceController.text.isEmpty ? 0 : num.parse(priceController.text);
  }

  void setProductQuantity(quantity) {
    if (quantity.isNotEmpty) {
      quantityController.value = TextEditingValue(text: quantity);
    } else {
      quantityController.clear();
    }
  }

  int getProductQuantity() {
    return quantityController.text.isEmpty
        ? 0
        : int.parse(quantityController.text);
  }

  void setAffectedExchangeState(state) {
    affectedExchangeState = state;
  }

  String getAffectedExchangeState() {
    return convertToAffectedExchangeState(affectedExchangeState.toString());
  }

  void setWholesalePrice(wholesalePrice) {
    if (wholesalePrice.isNotEmpty) {
      wholesalePriceController.value = TextEditingValue(text: wholesalePrice);
    } else {
      wholesalePriceController.clear();
    }
  }

  num getWholesalePrice() {
    return wholesalePriceController.text.isEmpty
        ? 0
        : num.parse(wholesalePriceController.text);
  }

  void setRetailPrice(retailPrice) {
    if (retailPrice.isNotEmpty) {
      retailPriceController.value = TextEditingValue(text: retailPrice);
    } else {
      retailPriceController.clear();
    }
  }

  num getRetailPrice() {
    return retailPriceController.text.isEmpty
        ? 0
        : num.parse(retailPriceController.text);
  }

  void setSupplierPrice(supplierPrice) {
    if (supplierPrice.isNotEmpty) {
      supplierPriceController.value = TextEditingValue(text: supplierPrice);
    } else {
      supplierPriceController.clear();
    }
  }

  num getSupplierPrice() {
    return supplierPriceController.text.isEmpty
        ? 0
        : num.parse(supplierPriceController.text);
  }

  void setProductImages(List<String> images) {
    productImages = images;
  }

  List<String> getProductImages() {
    return productImages;
  }

  void setProductDetails(Product? product) {
    if (product != null) {
      setProductName(product.name);
      setCategory(categoriesController.getCategoryFromId(product.categoryId));
      setProductPrice(product.initialPrice.toString());
      setProductQuantity(product.quantity.toString());
      setAffectedExchangeState(
          convertToCounterAffectedExchangeState(product.affectedExchange));
      setWholesalePrice(product.wholesalePrice);
      setSupplierPrice(product.supplierPrice);
      setRetailPrice(product.retailPrice);
      setProductImages(product.images);
    } else {
      setProductName('');
      setCategory(null);
      setProductPrice('');
      setProductQuantity('');
      setAffectedExchangeState('يتأثر');
      setWholesalePrice('');
      setSupplierPrice('');
      setRetailPrice('');
      setProductImages(<String>[]);
    }
  }

  Future<void> createProduct() async {
    savingState = false;
    String name = getProductName();
    int? categoryId = getCategoryId();
    num price = getProductPrice();
    int quantity = getProductQuantity();
    String exchangeState = getAffectedExchangeState();
    num wholesalePrice = getWholesalePrice();
    num supplierPrice = getSupplierPrice();
    num retailPrice = getRetailPrice();
    List<String> images = getProductImages();
    if (name.isNotEmpty) {
      setProductDetails(null);
      loading.value = true;
      var product = await prdouctsRepo.createProduct(
        name,
        categoryId,
        wholesalePrice,
        retailPrice,
        supplierPrice,
        quantity,
        exchangeState,
        price,
        MyApp.appUser!.id,
        images.isEmpty ? [] : images,
      );
      loading.value = false;
      if (product != null) {
        productsController.getProducts();
        savingState = true;
        SnackBars.showSuccess('تم انشاء المنتج');
      } else {
        SnackBars.showError('فشل انشاء المنتج');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateProduct(int id) async {
    String name = getProductName();
    int? categoryId = getCategoryId();
    num price = getProductPrice();
    int quantity = getProductQuantity();
    String exchangeState = getAffectedExchangeState();
    num wholesalePrice = getWholesalePrice();
    num supplierPrice = getSupplierPrice();
    num retailPrice = getRetailPrice();
    List<String> images = getProductImages();
    if (name.isNotEmpty) {
      loading.value = true;
      var product = await prdouctsRepo.updateProduct(
        id,
        name,
        categoryId,
        wholesalePrice,
        retailPrice,
        supplierPrice,
        quantity,
        exchangeState,
        price,
        MyApp.appUser!.id,
        images.isEmpty ? [] : images,
      );
      loading.value = false;
      if (product != null) {
        productsController.getProducts();
        SnackBars.showSuccess('تم التعديل بنجاح');
      } else {
        SnackBars.showError('فشل التعديل');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
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
    super.onInit();
  }
}
