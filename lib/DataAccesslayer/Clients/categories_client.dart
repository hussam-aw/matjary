import 'dart:convert';

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

  Future<dynamic> createCategory(name, userId) async {
    var response = await http.post(Uri.parse("$baseUrl$categoryLink"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
