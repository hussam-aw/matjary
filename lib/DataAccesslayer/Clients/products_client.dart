import 'package:http/http.dart' as http;
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/main.dart';

class ProductsClient {
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<dynamic> getProducts(connected) async {
    if (connected) {
      var response = await http
          .get(Uri.parse("$baseUrl$productsLink/${MyApp.appUser!.companyId}"));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } else {
      var data = await databaseHelper.getAllTableData(productsTableName);
      if (data.isNotEmpty) {
        return data;
      } else {
        return "";
      }
    }
  }

  Future<dynamic> createProduct(map) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink'));
    request.fields.addAll(map['primaryFileds']);
    for (String path in map['files']) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<dynamic> updateProduct(id, map) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$productLink/$id'));
    request.fields.addAll(map['primaryFileds']);
    for (String path in map['files']) {
      request.files.add(await http.MultipartFile.fromPath('images[]', path));
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<dynamic> deleteProduct(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$productLink/$id'));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
