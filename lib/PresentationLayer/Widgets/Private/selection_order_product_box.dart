import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/circle_text_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/update_order_product_bottomsheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class SelectionOrderProductBox extends StatelessWidget {
  SelectionOrderProductBox({
    super.key,
    required this.productId,
    required this.productName,
  });

  final int productId;
  final String productName;
  final orderScreenController = Get.find<OrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 60,
        color: orderScreenController.checkIfProductQuantityIsZero(productId)
            ? UIColors.containerBackground
            : UIColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleTextButton(
                    text: '+',
                    onTap: () {
                      orderScreenController.increaseProductQuantity(productId);
                    },
                  ),
                  spacerWidth(width: 5),
                  CircleTextButton(
                    text: '-',
                    onTap: () {
                      orderScreenController.decreaseProductQuantity(productId);
                    },
                  ),
                  spacerWidth(width: 5),
                  CircleTextButton(
                    text: '123',
                    textStyle: UITextStyle.normalSmall,
                    onTap: () {
                      Get.bottomSheet(UpdateOrderProductBottomSheet(
                        productId: productId,
                        currentQuantity: orderScreenController
                            .selectedProductsQuantities[productId],
                      ));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (orderScreenController
                              .selectedProductsQuantities[productId] ??
                          0)
                      .toString(),
                  style: UITextStyle.boldLarge,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
