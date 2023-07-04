import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/circle_text_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/update_order_product_bottomsheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

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
        //height: 60,
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
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
            Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    widget: Icon(
                      Icons.add,
                      color: UIColors.white,
                    ),
                    onTap: () {
                      orderScreenController.increaseProductQuantity(productId);
                    },
                  ),
                  spacerWidth(width: 5),
                  CircleButton(
                    widget: const Icon(
                      Icons.remove,
                      color: UIColors.white,
                    ),
                    onTap: () {
                      orderScreenController.decreaseProductQuantity(productId);
                    },
                  ),
                  spacerWidth(width: 5),
                  CircleButton(
                    widget: const Text(
                      '123',
                      style: UITextStyle.normalBody,
                    ),
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
            Container(
              width: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (orderScreenController
                              .selectedProductsQuantities[productId] ??
                          0)
                      .toString(),
                  //overflow: TextOverflow.ellipsis,
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
