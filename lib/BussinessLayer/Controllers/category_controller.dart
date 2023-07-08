import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  int? parentId;
  TextEditingController parentCategoryController = TextEditingController();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  CategoriesController categoriesController = Get.find<CategoriesController>();
  var loading = false.obs;

  void setCategoryDetails(Category? category) {
    if (category != null) {
      setCategoryName(category.name);
      setParentCategory(
          categoriesController.getCategoryFromId(category.parentId));
    }
  }

  void setCategoryName(categoryName) {
    nameController.value = TextEditingValue(text: categoryName);
  }

  void setParentCategory(category) {
    if (category != null) {
      parentId = category.id;
      parentCategoryController.value = TextEditingValue(
          text: categoriesController.getCategoryName(parentId));
    }
  }

  Future<void> createCategory() async {
    loading.value = true;
    var category = await categoriesRepo.createCategory(
        nameController.text, MyApp.appUser!.id, parentId);
    loading.value = false;

    if (category == null) {
      SnackBars.showWarning('حدث خطأ أثناء الإضافة');
    } else {
      categoriesController.getCategories();
      SnackBars.showSuccess('تمت إضافة فئة جديدة');
    }
  }

  Future<void> updateCategory(int id) async {
    loading.value = true;
    var category =
        await categoriesRepo.updateCategory(id, nameController.text, parentId);
    loading.value = false;
    if (category != null) {
      categoriesController.getCategories();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteCategory(id) async {
    loading.value = true;
    var category = await categoriesRepo.deleteCategory(id);
    loading.value = false;
    if (category != null) {
      categoriesController.getCategories();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
