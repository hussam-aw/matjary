import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/categories_client.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';

class CategoriesRepo {
  CategoriesClient client = CategoriesClient();
  Future<List<Category>> getCategories() async {
    var response = await client.getCategories();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Category>((json) => Category.fromMap(json)).toList();
    }
    return [];
  }

  Future<Category?> createCategory(name, userId) async {
    var data = await client.createCategory(name, userId);
    if (data != null) {
      final parsed = json.decode(data);
      return Category.fromMap(parsed);
    }
    return null;
  }
}
