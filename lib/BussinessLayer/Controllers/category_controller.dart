import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  int? parentId;
  TextEditingController parentCategoryController = TextEditingController();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  CategoriesController categoriesController = Get.find<CategoriesController>();
  var loading = false.obs;

  void setCategoryName(categoryName) {
    if (categoryName.isNotEmpty) {
      nameController.value = TextEditingValue(text: categoryName);
    } else {
      nameController.clear();
    }
  }

  String getCategoryName() {
    return nameController.text;
  }

  void setParentCategory(category) {
    if (category != null) {
      parentId = category.id;
      parentCategoryController.value = TextEditingValue(
          text: categoriesController.getCategoryName(parentId));
    } else {
      parentId = null;
      parentCategoryController.clear();
    }
  }

  void setCategoryDetails(Category? category) {
    if (category != null) {
      setCategoryName(category.name);
      setParentCategory(
          categoriesController.getCategoryFromId(category.parentId));
    } else {
      setCategoryName('');
      setParentCategory(null);
    }
  }

  Future<void> createCategory() async {
    String categoryName = getCategoryName();
    if (categoryName.isNotEmpty) {
      setCategoryDetails(null);
      loading.value = true;
      var category =
          await categoriesRepo.createCategory(categoryName, parentId);
      loading.value = false;

      if (category == null) {
        SnackBars.showWarning('حدث خطأ أثناء الإضافة');
      } else {
        categoriesController.getCategories();
        SnackBars.showSuccess('تمت إضافة فئة جديدة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateCategory(int id) async {
    String categoryName = getCategoryName();
    if (categoryName.isNotEmpty) {
      loading.value = true;
      var category =
          await categoriesRepo.updateCategory(id, categoryName, parentId);
      loading.value = false;
      if (category != null) {
        categoriesController.getCategories();
        SnackBars.showSuccess('تم التعديل بنجاح');
      } else {
        SnackBars.showError('فشل التعديل');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
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
