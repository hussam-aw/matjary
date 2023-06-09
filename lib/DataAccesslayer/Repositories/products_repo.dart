import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/products_client.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';

class PrdouctsRepo {
  ProductsClient client = ProductsClient();
  Future<List<Product>> getProducts() async {
    var response = await client.getProducts();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Product>((json) => Product.fromMap(json)).toList();
    }
    return [];
  }

  Future<Product?> createProduct(
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
    var updatedProduct = await client.createProduct(
        name,
        categoryId,
        wholesalePrice,
        retailPrice,
        supplierPrice,
        quantity,
        affectedExchange,
        initialPrice,
        userId,
        images);
    if (updatedProduct != null) {
      return Product.fromMap(jsonDecode(updatedProduct));
    }
    return null;
  }

  Future<Product?> updateProduct(
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
    var createdProduct = await client.updateProduct(
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
        images);
    if (createdProduct != null) {
      return Product.fromMap(jsonDecode(createdProduct));
    }
    return null;
  }

  Future<Product?> deleteProduct(id) async {
    var deletedProduct = await client.deleteProduct(id);
    if (deletedProduct != null) {
      return Product.fromMap(jsonDecode(deletedProduct));
    }
    return null;
  }
}
