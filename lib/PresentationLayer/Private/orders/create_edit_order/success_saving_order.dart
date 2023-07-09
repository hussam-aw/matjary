import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SuccessSavingOrder extends StatelessWidget {
  SuccessSavingOrder({super.key});

  final orderScreenController = Get.find<OrderScreenController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: UIColors.containerBackground,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 80,
                        color: UIColors.white,
                      ),
                    ),
                    spacerHeight(),
                    const Text(
                      'تم الحفظ بنجاح',
                      style: UITextStyle.boldHeading,
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(height: 22),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AcceptButton(
                  onPressed: () {
                    orderController.resetOrder();
                    orderController.setDefaultFields();
                    orderScreenController.resetOrderScreen();
                    orderScreenController.goToInitialPage();
                  },
                  backgroundColor: UIColors.primary,
                  text: 'إنشاء فاتورة جديدة',
                ),
                spacerHeight(),
                AcceptButton(
                  text: 'العودة للرئيسية',
                  style: acceptButtonWithBorderStyle,
                  textStyle: UITextStyle.boldMeduim.copyWith(
                    color: UIColors.smallText,
                  ),
                  backgroundColor: UIColors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
