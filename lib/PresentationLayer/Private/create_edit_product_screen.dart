import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/categories_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/product_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/product_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateEditProductScreen extends StatelessWidget {
  CreateEditProductScreen({super.key});

  final productController = Get.put(ProductController());
  final productScreenController = Get.put(ProductScreenController());
  final categoriesController = Get.find<CategoriesController>();

  final Product? product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    productController.setProductDetails(product);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const PageTitle(title: 'إنشاء | تعديل منتج'),
                    ),
                    if (product != null)
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                              title: 'هل تريد حذف المنتج؟',
                              buttonText: 'حذف',
                              confirmOnPressed: () async {
                                await productController
                                    .deleteProduct(product!.id);
                                Get.until((route) =>
                                    route.settings.name ==
                                    AppRoutes.chooseProductScreen);
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: UIColors.primary,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle(title: 'المعلومات الأساسية'),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: productController.nameController,
                              hintText: 'اسم المنتج',
                            ),
                            spacerHeight(),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    readOnly: true,
                                    controller: productController
                                        .categoryNameController,
                                    hintText: 'غير مصنف',
                                  ),
                                ),
                                spacerWidth(),
                                CustomIconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    color: UIColors.mainIcon,
                                  ),
                                  onPressed: () async {
                                    var category = await Get.toNamed(
                                      AppRoutes.chooseCategoryScreen,
                                      arguments: 'selection',
                                    );
                                    productController.setCategory(category);
                                  },
                                ),
                              ],
                            ),
                            spacerHeight(),
                            CustomTextFormField(
                              controller:
                                  productController.initialPriceController,
                              keyboardType: TextInputType.number,
                              hintText: 'مبلغ الكلفة الحالي (الافتراضي 0)',
                            ),
                            spacerHeight(height: 20),
                            CustomTextFormField(
                              controller: productController.quantityController,
                              keyboardType: TextInputType.number,
                              hintText:
                                  'الكمية الابتدائية (الجرد الأولي) (الكمية الابتدائية 0)',
                            ),
                            spacerHeight(height: 20),
                            const SectionTitle(title: 'يتأثر بتغيرات الصرف'),
                            spacerHeight(),
                            GetBuilder(
                                init: productScreenController,
                                builder: (context) {
                                  productScreenController
                                      .setAffectedExchangeState(
                                          productController
                                              .affectedExchangeState);
                                  return CustomRadioGroup(
                                    items: [
                                      RadioButtonItem(
                                          text: 'يتأثر',
                                          isSelected:
                                              productScreenController.affected,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            productController
                                                    .affectedExchangeState =
                                                'يتأثر';
                                            productScreenController
                                                .changeAffectedExchangeState(
                                                    'يتأثر');
                                          }),
                                      RadioButtonItem(
                                          text: 'لا يتأثر',
                                          isSelected: productScreenController
                                              .notAffected,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            productController
                                                    .affectedExchangeState =
                                                'لا يتأثر';
                                            productScreenController
                                                .changeAffectedExchangeState(
                                                    'لا يتأثر');
                                          })
                                    ],
                                  );
                                }),
                            spacerHeight(height: 20),
                            const SectionTitle(title: 'أسعار البيع'),
                            spacerHeight(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: productController
                                        .wholesalePriceController,
                                    keyboardType: TextInputType.number,
                                    style: UITextStyle.normalBody,
                                    decoration: subTextFieldStyle.copyWith(
                                      hintText: 'الجملة 0',
                                    ),
                                  ),
                                ),
                                spacerWidth(),
                                Expanded(
                                  child: TextFormField(
                                    controller: productController
                                        .supplierPriceController,
                                    keyboardType: TextInputType.number,
                                    style: UITextStyle.normalBody,
                                    decoration: subTextFieldStyle.copyWith(
                                      hintText: 'الموزع 0',
                                    ),
                                  ),
                                ),
                                spacerWidth(),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        productController.retailPriceController,
                                    keyboardType: TextInputType.number,
                                    style: UITextStyle.normalBody,
                                    decoration: subTextFieldStyle.copyWith(
                                      hintText: 'المفرق 0',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            spacerHeight(),
                            GetBuilder(
                              init: productScreenController,
                              builder: (context) {
                                return productScreenController
                                        .selectedImages.isEmpty
                                    ? product != null &&
                                            product!.images.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: raduis15,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                product!.images[
                                                                    index]),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return spacerWidth();
                                                  },
                                                  itemCount:
                                                      product!.images.length,
                                                ),
                                              ),
                                              spacerHeight(),
                                            ],
                                          )
                                        : Container()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: raduis15,
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            productScreenController
                                                                    .selectedImages[
                                                                index])),
                                                        fit: BoxFit.cover),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return spacerWidth();
                                              },
                                              itemCount: productScreenController
                                                  .selectedImages.length,
                                            ),
                                          ),
                                          spacerHeight(),
                                        ],
                                      );
                              },
                            ),
                            AccetpIconButton(
                              center: true,
                              text: Text(
                                'صور المنتج',
                                style: UITextStyle.normalBody.copyWith(
                                  color: UIColors.menuTitle,
                                ),
                              ),
                              icon: const Icon(
                                FontAwesomeIcons.images,
                                size: 20,
                                color: UIColors.mainIcon,
                              ),
                              backgroundColor: UIColors.white,
                              onPressed: () async {
                                productScreenController.getSelectedImages();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                spacerHeight(height: 30),
                Obx(
                  () => AcceptButton(
                    text: product != null ? "تعديل" : "إنشاء",
                    onPressed: () {
                      productController
                          .setImages(productScreenController.selectedImages);
                      if (product != null) {
                        productController.updateProduct(product!.id);
                      } else {
                        productController.createProduct();
                      }
                    },
                    isLoading: productController.loading.value,
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
