import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/DataAccesslayer/Repositories/user_repo.dart';
import 'package:matjary/main.dart';

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
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink'));
    request.fields.addAll({
      'name': name.toString(),
      'category_id': categoryId.toString(),
      'special_number': specialNumber.toString(),
      'wholesale_price': wholesalePrice.toString(),
      'retail_price': retailPrice.toString(),
      'supplier_price': supplierPrice.toString(),
      'quantity': quantity.toString(),
      'affected_exchange': affectedExchange.toString(),
      'initial_price': initialPrice.toString(),
      'user_id': MyApp.appUser!.id.toString(),
    });
    for (String path in images) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      print(response.statusCode);
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
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink/$id'));
    request.fields.addAll({
      'name': name.toString(),
      'category_id': categoryId.toString(),
      'special_number': specialNumber.toString(),
      'wholesale_price': wholesalePrice.toString(),
      'retail_price': retailPrice.toString(),
      'supplier_price': supplierPrice.toString(),
      'quantity': quantity.toString(),
      'affected_exchange': affectedExchange.toString(),
      'initial_price': initialPrice.toString(),
      'user_id': MyApp.appUser!.id.toString(),
    });
    for (String path in images) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      print(response.statusCode);
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
