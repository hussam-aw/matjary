import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/product_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/selection_order_product_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class SelectProductsScreen extends StatelessWidget {
  SelectProductsScreen({super.key});

  final productsController = Get.find<ProductsController>();
  final searchController = Get.put(SearchController());
  final orderScreenController = Get.find<OrderScreenController>();

  Widget buildProductsList(productsList) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SelectionOrderProductBox(
          productId: productsController.products[index].id,
          productName: productsController.products[index].name,
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
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            children: [
              const PageTitle(title: 'اختيار منتجات'),
              spacerHeight(),
              TextFormField(
                textAlign: TextAlign.center,
                style: UITextStyle.normalMeduim,
                decoration: normalTextFieldStyle.copyWith(
                  hintText: 'اكتب اسم المنتج أو جزء منه للفلترة',
                ),
                onChanged: (value) {
                  searchController.searchText = value;
                  searchController.search();
                },
              ),
              spacerHeight(height: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.circleInfo,
                    size: 37,
                    color: UIColors.white,
                  ),
                  spacerWidth(),
                  SizedBox(
                    width: 210,
                    child: Text(
                      'قم بزيادة العدد لاختيار المنتج بأزرار الزيادة والنقصان أو قم بإدخاله بالضغط على 123',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: UITextStyle.normalSmall.copyWith(
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              spacerHeight(height: 22),
              Expanded(
                child: GetBuilder(
                    init: searchController,
                    builder: (context) {
                      return searchController.searchText.isEmpty
                          ? buildProductsList(productsController.products)
                          : Obx(() {
                              return searchController.searchLoading.value
                                  ? Center(
                                      child: loadingItem(
                                          width: 100, isWhite: true),
                                    )
                                  : buildProductsList(
                                      searchController.filteredList);
                            });
                    }),
              ),
              spacerHeight(),
              AcceptButton(
                text: 'اختيار',
                onPressed: () {
                  orderScreenController.getSelectedProducts();
                  orderScreenController.setOrderProducts();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
