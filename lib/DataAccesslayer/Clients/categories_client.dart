import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class CategoriesClient {
  Future<dynamic> getCategories() async {
    var response = await http.get(Uri.parse("$baseUrl$categoriesLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
