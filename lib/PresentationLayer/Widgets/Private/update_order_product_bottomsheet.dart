import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class UpdateOrderProductBottomSheet extends StatelessWidget {
  UpdateOrderProductBottomSheet(
      {super.key,
      required this.productId,
      this.currentQuantity,
      this.currentPrice});

  final orderScreenController = Get.find<OrderScreenController>();
  final orderController = Get.find<OrderController>();

  final int productId;
  final currentQuantity;
  final currentPrice;

  @override
  Widget build(BuildContext context) {
    orderScreenController.productQuantityController.text =
        currentQuantity != null ? currentQuantity.toString() : '';
    orderScreenController.productPriceController.text =
        currentPrice != null ? currentPrice.toString() : '';
    return Container(
      height: Get.width * .6,
      decoration: const BoxDecoration(
        borderRadius: raduis32top,
        color: UIColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Column(
          children: [
            Row(
              children: [
                if (currentPrice != null)
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'السعر',
                          style: UITextStyle.normalMeduim
                              .copyWith(color: UIColors.darkText),
                        ),
                        spacerHeight(),
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller:
                              orderScreenController.productPriceController,
                          keyboardType: TextInputType.number,
                          decoration: normalTextFieldStyle,
                        ),
                      ],
                    ),
                  ),
                spacerWidth(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'الكمية',
                        style: UITextStyle.normalMeduim
                            .copyWith(color: UIColors.darkText),
                      ),
                      spacerHeight(),
                      TextFormField(
                        textAlign: TextAlign.center,
                        controller:
                            orderScreenController.productQuantityController,
                        keyboardType: TextInputType.number,
                        decoration: normalTextFieldStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
            spacerHeight(height: 30),
            AcceptButton(
              text: 'تأكيد',
              onPressed: () {
                orderScreenController.setProductQuantity(productId);
                orderScreenController.setProductsQuantities();
                if (currentPrice != null) {
                  orderScreenController.setProductPrice(productId);
                  orderScreenController.setProductsPrices();
                }
                orderController.calculateTotalProductsPrice();
                orderController.calculateTotalOrderAmount();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
