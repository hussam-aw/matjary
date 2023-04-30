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
