import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/BussinessLayer/helpers/numerical_range_formatter.dart';
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
                      return orderScreenController
                                  .marketerDiscountSelection.value['رقم'] ==
                              true
                          ? marketerDiscountTextField('5000', [
                              FilteringTextInputFormatter.digitsOnly,
                            ])
                          : marketerDiscountTextField('100%', [
                              FilteringTextInputFormatter.digitsOnly,
                              NumericalRangeFormatter(min: 0, max: 100)
                            ]);
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
                          controller: orderController.paidAmountController,
                          hintText: '300.000',
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            orderController.calculateRemainingAmount(value);
                          },
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
                        Obx(() {
                          return CustomTextFormField(
                            readOnly: true,
                            controller:
                                orderController.remainingAmountController,
                            hintText: orderController.totalOrderAmount.value
                                .toStringAsFixed(2),
                          );
                        })
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

  Widget marketerDiscountTextField(
      String hintText, List<TextInputFormatter>? formatters) {
    return CustomTextFormField(
      controller: orderController.marketerDiscountController,
      formatters: formatters,
      keyboardType: TextInputType.number,
      hintText: hintText,
      suffix: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10),
        child: CustomRadioGroup(
          scrollDirection: Axis.vertical,
          items: orderScreenController.discountOrderTypes.keys
              .map((discountType) => RadioButtonItem(
                    text: discountType,
                    width: Get.width * .15,
                    style: UITextStyle.boldSmall,
                    selectionColor: UIColors.primary,
                    unselectionColor: UIColors.mainBackground,
                    selectedTextColor: UIColors.white,
                    isSelected: orderScreenController
                        .marketerDiscountSelection.value[discountType]!,
                    onTap: () {
                      orderScreenController.setMarketerDiscount(discountType);
                      orderController.setMarketerDiscountType(
                          orderScreenController
                              .discountOrderTypes[discountType]);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
