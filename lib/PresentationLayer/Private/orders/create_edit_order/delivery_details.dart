import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/BussinessLayer/helpers/numerical_range_formatter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class DeliveryDetails extends StatelessWidget {
  DeliveryDetails({super.key});

  final orderScreenController = Get.find<OrderScreenController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'نوع البيع'),
                spacerHeight(),
                Obx(
                  () {
                    return CustomRadioGroup(
                      scrollDirection: Axis.horizontal,
                      items: orderScreenController.buyingTypes.keys
                          .map((buyingType) => RadioButtonItem(
                                text: buyingType,
                                selectionColor: UIColors.primary,
                                selectedTextColor: UIColors.white,
                                isSelected: orderScreenController
                                    .buyingTypesSelection.value[buyingType]!,
                                onTap: () {
                                  orderScreenController
                                      .setbuyingType(buyingType);
                                  orderController.setBuyingType(
                                      orderScreenController
                                          .buyingTypes[buyingType]);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
                spacerHeight(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SectionTitle(title: 'مصاريف الفاتورة'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: orderController.expensesController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            hintText: 'أدخل المبلغ (اختياري)',
                            formatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            onChanged: (value) {
                              orderController.convertExpensesToDouble(value);
                              orderController.calculateTotalOrderAmount();
                            },
                          ),
                        ],
                      ),
                    ),
                    spacerWidth(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          const SectionTitle(title: 'الحسم على الفاتورة'),
                          spacerHeight(),
                          Obx(() {
                            return orderScreenController
                                        .discountOrderTypesSelection
                                        .value['رقم'] ==
                                    true
                                ? Obx(() {
                                    return discountTextField(
                                        'أدخل المبلغ (اختياري)',
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: false),
                                        [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                          NumericalRangeFormatter(
                                              min: 0.0,
                                              max: orderController
                                                  .totalProductsPrice.value)
                                        ]);
                                  })
                                : discountTextField(
                                    '100%', TextInputType.number, [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericalRangeFormatter(min: 0, max: 100)
                                  ]);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                spacerHeight(height: 22),
                const SectionTitle(title: 'حالة الطلب'),
                spacerHeight(),
                Obx(
                  () {
                    return CustomRadioGroup(
                      scrollDirection: Axis.horizontal,
                      items: orderScreenController.orderStatus.keys
                          .map((orderStatus) => RadioButtonItem(
                                text: orderStatus,
                                selectionColor: UIColors.primary,
                                selectedTextColor: UIColors.white,
                                isSelected: orderScreenController
                                    .orderStatusSelection.value[orderStatus]!,
                                onTap: () {
                                  orderScreenController
                                      .setOrderStatus(orderStatus);
                                  orderController.setStatus(
                                      orderScreenController
                                          .orderStatus[orderStatus]);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
                spacerHeight(height: 22),
                const SectionTitle(title: 'ملاحظات'),
                spacerHeight(),
                CustomTextFormField(
                  controller: orderController.notesController,
                  maxLines: 5,
                  hintText: 'شب التوصيل: حسام',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget discountTextField(
      String hintText, keyboardType, List<TextInputFormatter>? formatters) {
    return CustomTextFormField(
      controller: orderController.discountOrderController,
      formatters: formatters,
      keyboardType: keyboardType,
      hintText: hintText,
      suffix: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 12, top: 5, bottom: 4),
        child: CustomRadioGroup(
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 6,
          childAspectRatio: .25,
          items: orderScreenController.discountOrderTypes.keys
              .map((discountType) => RadioButtonItem(
                    text: discountType,
                    width: Get.width * .15,
                    style: UITextStyle.boldSmall,
                    selectionColor: UIColors.primary,
                    unselectionColor: UIColors.mainBackground,
                    selectedTextColor: UIColors.white,
                    isSelected: orderScreenController
                        .discountOrderTypesSelection.value[discountType]!,
                    onTap: () {
                      orderScreenController.setDiscountType(discountType);
                      orderController.setDiscountType(orderScreenController
                          .discountOrderTypes[discountType]);
                    },
                  ))
              .toList(),
        ),
      ),
      onChanged: (value) {
        orderController.calculateDiscountBasedOnType();
        orderController.calculateTotalOrderAmount();
      },
    );
  }
}
