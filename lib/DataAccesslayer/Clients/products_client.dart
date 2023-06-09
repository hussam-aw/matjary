import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class ProductsClient {
  Future<dynamic> getProducts() async {
    var response = await http
        .get(Uri.parse("$baseUrl$productsLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createProduct(
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
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink'));
    request.fields.addAll({
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
    });
    for (String path in images) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }

  Future<dynamic> updateProduct(
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
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink/$id'));
    request.fields.addAll({
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
    });
    for (String path in images) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }

  Future<dynamic> deleteProduct(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$productLink/$id'));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
