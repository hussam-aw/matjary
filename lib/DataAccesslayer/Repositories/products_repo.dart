import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/products_client.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
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
}
