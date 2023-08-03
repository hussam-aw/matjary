import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/product_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';

class ProductOptionsMenu extends StatelessWidget {
  ProductOptionsMenu({super.key, required this.product});

  final productController = Get.put(ProductController());
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.createEditProductScreen,
                arguments: product,
              );
            },
            child: Text(
              'تعديل',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.productQtyReportScreen,
                arguments: product,
              );
            },
            child: Text(
              'جرد المنتج',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.productMovementReportScreen,
                arguments: {'product': product},
              );
            },
            child: Text(
              'حركة المنتج',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.dialog(
                CustomDialog(
                  title: 'هل تريد حذف المنتج؟',
                  acceptButton: Obx(
                    () => AcceptButton(
                      text: 'حذف',
                      onPressed: () async {
                        await productController.deleteProduct(product.id);
                        Get.until((route) =>
                            route.settings.name ==
                            AppRoutes.chooseProductScreen);
                      },
                      isLoading: productController.loading.value,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'حذف المنتج',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
