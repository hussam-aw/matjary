import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class CategoriesClient {
  Future<dynamic> getCategories() async {
    var response = await http
        .get(Uri.parse("$baseUrl$categoriesLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createCategory(name, userId, parentId) async {
    var response = await http.post(Uri.parse("$baseUrl$categoryLink"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": MyApp.appUser!.id,
          "parent_id": parentId,
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

  Future<dynamic> updateCategory(id, name, parentId) async {
    var response = await http.post(Uri.parse('$baseUrl$categoryLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": MyApp.appUser!.id,
          "parent_id": parentId,
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

  Future<dynamic> deleteCategory(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$categoryLink/$id'));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
