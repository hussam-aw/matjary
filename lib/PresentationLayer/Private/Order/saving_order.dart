import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/order_amount_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class SavingOrder extends StatelessWidget {
  SavingOrder({super.key});

  final orderScreenController = Get.find<OrderScreenController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(() {
                    return OrderAmountContainer(
                      title: 'المبلغ الاجمالي',
                      amount: orderController.totalProductsPrice.value
                          .toStringAsFixed(2),
                    );
                  }),
                  spacerWidth(width: 25),
                  Obx(() {
                    return OrderAmountContainer(
                      title: 'المصاريف',
                      amount: orderController.expenses.value.toStringAsFixed(2),
                    );
                  }),
                ],
              ),
              spacerHeight(),
              Row(
                children: [
                  Obx(() {
                    return OrderAmountContainer(
                      title: 'مبلغ الحسم',
                      amount: orderController.discountAmount.value
                          .toStringAsFixed(2),
                    );
                  }),
                  spacerWidth(width: 25),
                  Obx(() {
                    return OrderAmountContainer(
                      title: 'صافي الفاتورة',
                      amount: orderController.totalOrderAmount.value
                          .toStringAsFixed(2),
                    );
                  }),
                ],
              ),
              spacerHeight(height: 22),
              if (orderController.marketerController.text.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: 'نسبة المسوق ( البائع )'),
                    spacerHeight(),
                    Obx(() {
                      return CustomTextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                        hintText: '5000',
                        suffix: Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomRadioGroup(
                            scrollDirection: Axis.vertical,
                            items: orderScreenController.discountOrderTypes
                                .map((discountType) => RadioButtonItem(
                                      text: discountType,
                                      width: Get.width * .13,
                                      style: UITextStyle.smallBold,
                                      selectionColor: UIColors.primary,
                                      unselectionColor: UIColors.mainBackground,
                                      selectedTextColor: UIColors.white,
                                      isSelected: orderScreenController
                                          .discountOrderTypesSelection
                                          .value[discountType]!,
                                      onTap: () {
                                        orderScreenController
                                            .setDiscountType(discountType);
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    }),
                    spacerHeight(height: 22),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'المبلغ المدفوع',
                          style: UITextStyle.normalBody.copyWith(
                            color: UIColors.normalText,
                          ),
                        ),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: TextEditingController(),
                          hintText: '300.000',
                        )
                      ],
                    ),
                  ),
                  spacerWidth(),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'المبلغ المتبقي',
                          style: UITextStyle.normalBody.copyWith(
                            color: UIColors.normalText,
                          ),
                        ),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: TextEditingController(),
                          hintText: '200.000',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
