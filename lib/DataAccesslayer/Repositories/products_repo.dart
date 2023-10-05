import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/products_client.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/main.dart';

class PrdouctsRepo {
  ProductsClient client = ProductsClient();

  Future<List<Product>> getProducts(connected) async {
    var response = await client.getProducts(connected);
    if (response != "") {
      var parsed = response;
      if (connected) {
        parsed = json.decode(response).cast<Map<String, dynamic>>();
      }
      return parsed.map<Product>((json) => Product.fromMap(json)).toList();
    }
    return [];
  }

  Future<bool> createProduct(
      name,
      categoryId,
      wholesalePrice,
      retailPrice,
      supplierPrice,
      quantity,
      affectedExchange,
      initialPrice,
      userId,
      images) async {
    var productFieldsMap = {
      'primaryFileds': {
        'name': name.toString(),
        'category_id': categoryId.toString(),
        'wholesale_price': wholesalePrice.toString(),
        'retail_price': retailPrice.toString(),
        'supplier_price': supplierPrice.toString(),
        'quantity': quantity.toString(),
        'affected_exchange': affectedExchange.toString(),
        'initial_price': initialPrice.toString(),
        'user_id': MyApp.appUser!.id.toString(),
        'company_id': MyApp.appUser!.companyId.toString(),
      },
      'files': images,
    };
    var isProductCreated = await client.createProduct(productFieldsMap);
    if (isProductCreated) {
      return true;
    }
    return false;
  }

  Future<bool> updateProduct(
      id,
      name,
      categoryId,
      wholesalePrice,
      retailPrice,
      supplierPrice,
      quantity,
      affectedExchange,
      initialPrice,
      userId,
      images) async {
    var productFieldsMap = {
      'primaryFileds': {
        'name': name.toString(),
        'category_id': categoryId.toString(),
        'wholesale_price': wholesalePrice.toString(),
        'retail_price': retailPrice.toString(),
        'supplier_price': supplierPrice.toString(),
        'quantity': quantity.toString(),
        'affected_exchange': affectedExchange.toString(),
        'initial_price': initialPrice.toString(),
        'user_id': MyApp.appUser!.id.toString(),
        'company_id': MyApp.appUser!.companyId.toString(),
      },
      'files': images,
    };
    var isProductUpdated = await client.updateProduct(id, productFieldsMap);
    if (isProductUpdated) {
      return true;
    }
    return false;
  }

  Future<bool> deleteProduct(id) async {
    var isProductDeleted = await client.deleteProduct(id);
    if (isProductDeleted) {
      return true;
    }
    return false;
  }
}
