import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/product_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseProductScreen extends StatelessWidget {
  ChooseProductScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final ProductController productController = Get.put(ProductController());
  final SearchController searchController = Get.put(SearchController());
  late var controller;

  String? screenMode = Get.arguments;

  Widget buildProductsList(productsList) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return screenMode == null
            ? CustomBox(
                title: productsList[index].name,
                editOnPressed: () {
                  Get.toNamed(AppRoutes.createEditProductScreen,
                      arguments: productsList[index]);
                },
                deleteDialogTitle: 'هل تريد بالتأكيد حذف المنتج؟',
                deleteOnPressed: () {
                  controller.deleteProduct(productsList[index].id);
                  Get.back();
                },
              )
            : NormalBox(
                title: productsList[index].name,
                onTap: () {
                  controller.setAccountBasedOnType(
                      productsList[index].name, screenMode);
                },
              );
      },
      separatorBuilder: (context, index) {
        return spacerHeight();
      },
      itemCount: productsList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    searchController.list = homeController.products;
    if (screenMode == null) {
      controller = Get.put(ProductController());
    } else {
      controller = Get.find<OrderController>();
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
                const PageTitle(title: 'إختيار منتج'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم المنتج أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => homeController.isLoadingProducts.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : GetBuilder(
                            init: searchController,
                            builder: (context) {
                              return searchController.searchText.isEmpty
                                  ? buildProductsList(homeController.products)
                                  : Obx(() {
                                      return searchController
                                              .searchLoading.value
                                          ? Center(
                                              child: loadingItem(
                                                  width: 100, isWhite: true),
                                            )
                                          : buildProductsList(
                                              searchController.filteredList);
                                    });
                            }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
