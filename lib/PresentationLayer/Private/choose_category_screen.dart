import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/category_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/ware_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseCategoryScreen extends StatelessWidget {
  ChooseCategoryScreen({super.key});

  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  final SearchController searchController = Get.put(SearchController());
  late var controller;

  String? screenMode = Get.arguments;

  Widget buildCategoriesList(cateoriesList) {
    List<dynamic> categoriesWidgetList = screenMode == null
        ? cateoriesList
            .map((category) => CustomBox(
                  title: category.name,
                  editOnPressed: () {
                    Get.toNamed(AppRoutes.createEditCategoryScreen,
                        arguments: category);
                  },
                  deleteDialogTitle: 'هل تريد بالتأكيد حذف التصنيف؟',
                  deleteOnPressed: () {
                    controller.deleteCategory(category.id);
                    Get.back();
                  },
                ))
            .toList()
        : cateoriesList
            .map((category) => NormalBox(
                  title: category.name,
                  onTap: () {
                    Get.back(
                      result: category,
                    );
                  },
                ))
            .toList();
    if (screenMode != null) {
      categoriesWidgetList.insert(
          0,
          NormalBox(
              title: 'غير مصنف',
              onTap: () {
                Get.back(result: null);
              }));
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return categoriesWidgetList[index];
      },
      separatorBuilder: (context, index) {
        return spacerHeight();
      },
      itemCount: categoriesWidgetList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    searchController.list = categoriesController.categories;
    if (screenMode == null) {
      controller = Get.put(CategoryController());
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إختيار فئة'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن الفئة أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => categoriesController.isLoadingCategories.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await categoriesController.getCategories(),
                            child: GetBuilder(
                                init: searchController,
                                builder: (context) {
                                  return searchController.searchText.isEmpty
                                      ? buildCategoriesList(
                                          categoriesController.categories)
                                      : Obx(() {
                                          return searchController
                                                  .searchLoading.value
                                              ? Center(
                                                  child: loadingItem(
                                                      width: 100,
                                                      isWhite: true),
                                                )
                                              : buildCategoriesList(
                                                  searchController
                                                      .filteredList);
                                        });
                                }),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AddButton(
          backgroundColor: UIColors.primary,
          iconColor: UIColors.white,
          onPressed: () {
            Get.toNamed(AppRoutes.createEditCategoryScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
