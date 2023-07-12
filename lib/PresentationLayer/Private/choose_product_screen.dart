import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
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
class ChooseProductScreen extends StatelessWidget {
  ChooseProductScreen({super.key});

  final ProductsController productsController = Get.find<ProductsController>();
  final ListSearchController searchController = Get.put(ListSearchController());

  String? screenMode = Get.arguments;

  Widget buildProductsList(productsList) {
    return productsList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد منتجات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return NormalBox(
                title: productsList[index].name,
                onTap: () {
                  if (screenMode == null) {
                    Get.toNamed(AppRoutes.createEditProductScreen,
                        arguments: productsList[index]);
                  } else {
                    Get.toNamed(
                      AppRoutes.productQtyReportScreen,
                      arguments: productsList[index],
                    );
                  }
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
    searchController.list = productsController.products;

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
                    () => productsController.isLoadingProducts.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await productsController.getProducts(),
                            child: GetBuilder(
                                init: searchController,
                                builder: (context) {
                                  return searchController.searchText.isEmpty
                                      ? buildProductsList(
                                          productsController.products)
                                      : Obx(() {
                                          return searchController
                                                  .searchLoading.value
                                              ? Center(
                                                  child: loadingItem(
                                                      width: 100,
                                                      isWhite: true),
                                                )
                                              : buildProductsList(
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
            Get.toNamed(AppRoutes.createEditProductScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
