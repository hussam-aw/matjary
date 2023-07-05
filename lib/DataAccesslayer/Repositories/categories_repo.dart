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

  Future<Category?> createCategory(name, userId, parentId) async {
    var data = await client.createCategory(name, userId, parentId);
    if (data != null) {
      final parsed = json.decode(data);
      return Category.fromMap(parsed);
    }
    return null;
  }

  Future<Category?> updateCategory(id, name, parentId) async {
    var updatedCategory = await client.updateCategory(id, name, parentId);
    if (updatedCategory != null) {
      return Category.fromMap(jsonDecode(updatedCategory));
    }
    return null;
  }

  Future<Category?> deleteCategory(id) async {
    var deletedCategory = await client.deleteCategory(id);

    if (deletedCategory != null) {
      return Category.fromMap(jsonDecode(deletedCategory));
    }
    return null;
  }
}
