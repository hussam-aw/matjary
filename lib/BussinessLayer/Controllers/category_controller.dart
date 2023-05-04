import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/DataAccesslayer/Repositories/categories_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  HomeController homeController = Get.find<HomeController>();
  var loading = false.obs;

  Future<void> createCategory() async {
    loading.value = true;
    var category = await categoriesRepo.createCategory(
        nameController.text, MyApp.appUser!.id);
    loading.value = false;

    if (category == null) {
      SnackBars.showSuccess('حدث خطأ أثناء الإضافة');
    } else {
      homeController.getCategories();
      SnackBars.showSuccess('تمت إضافة فئة جديدة');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
