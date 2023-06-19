import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';

class CategoriesController extends GetxController {
  CategoriesRepo categoriesRepo = CategoriesRepo();
  List<Category> categories = [];
  var isLoadingCategories = false.obs;

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    categories = await categoriesRepo.getCategories();
    isLoadingCategories.value = false;
  }

  Category? getCategoryFromId(categoryId) {
    var category =
        categories.firstWhereOrNull((category) => category.id == categoryId);
    if (category != null) {
      return category;
    }
    return null;
  }

  String getCategoryName(int? id) {
    return getCategoryFromId(id) != null ? getCategoryFromId(id)!.name : '';
  }
}
