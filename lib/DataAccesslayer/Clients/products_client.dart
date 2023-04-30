import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class ProductsClient {
  Future<dynamic> getProducts() async {
    var response = await http.get(Uri.parse("$baseUrl$productsLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createProduct(
      name,
      categoryId,
      specialNumber,
      wholesalePrice,
      retailPrice,
      supplierPrice,
      quantity,
      affectedExchange,
      initialPrice,
      userId,
      images) async {
    var response = await http.post(Uri.parse('$baseUrl$productLink'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "category_id": categoryId,
          "special_number": specialNumber,
          "wholesale_price": wholesalePrice,
          "retail_price": retailPrice,
          "supplier_price": supplierPrice,
          "quantity": quantity,
          "affected_exchange": affectedExchange,
          "initial_price": initialPrice,
          "user_id": userId,
          "images": images,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> updateProduct(
      id,
      name,
      categoryId,
      specialNumber,
      wholesalePrice,
      retailPrice,
      supplierPrice,
      quantity,
      affectedExchange,
      initialPrice,
      userId,
      images) async {
    var response = await http.post(Uri.parse('$baseUrl$productLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "category_id": categoryId,
          "special_number": specialNumber,
          "wholesale_price": wholesalePrice,
          "retail_price": retailPrice,
          "supplier_price": supplierPrice,
          "quantity": quantity,
          "affected_exchange": affectedExchange,
          "initial_price": initialPrice,
          "user_id": userId,
          "images": images,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteProduct(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$productLink/$id'));

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
