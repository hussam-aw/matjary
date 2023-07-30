import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class ChooseCategoryScreen extends StatelessWidget {
  ChooseCategoryScreen({super.key});

  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  final ListSearchController searchController = Get.put(ListSearchController());
  String? screenMode = Get.arguments;

  Widget buildCategoriesList(cateoriesList) {
    List<dynamic> categoriesWidgetList = cateoriesList
        .map((category) => NormalBox(
              title: category.name,
              onTap: () {
                if (screenMode == null) {
                  Get.toNamed(AppRoutes.createEditCategoryScreen,
                      arguments: category);
                } else {
                  Get.back(
                    result: category,
                  );
                }
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
    return cateoriesList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد تصنيفات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
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
    searchController.setSearchList(categoriesController.categories);
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
                const PageTitle(title: 'تصنيفات البضاعة'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن التصنيف أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.search(value);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
