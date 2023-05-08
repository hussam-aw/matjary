import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'نوع البيع'),
              spacerHeight(),
              Obx(
                () {
                  return CustomRadioGroup(
                    items: orderScreenController.buyingTypes
                        .map((buyingType) => RadioButtonItem(
                              text: buyingType,
                              selectionColor: UIColors.primary,
                              selectedTextColor: UIColors.white,
                              isSelected: orderScreenController
                                  .buyingTypesSelection.value[buyingType]!,
                              onTap: () {
                                orderScreenController.setbuyingType(buyingType);
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
                          controller: TextEditingController(),
                          keyboardType: TextInputType.number,
                          hintText: '5000',
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
                        CustomTextFormField(
                          controller: TextEditingController(),
                          keyboardType: TextInputType.number,
                          hintText: '5000',
                          suffix: Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: Obx(
                              () {
                                return CustomRadioGroup(
                                  scrollDirection: Axis.vertical,
                                  items: orderScreenController.discountTypes
                                      .map((discountType) => RadioButtonItem(
                                            text: discountType,
                                            width: Get.width * .1,
                                            style: UITextStyle.smallBold,
                                            selectionColor: UIColors.primary,
                                            unselectionColor:
                                                UIColors.mainBackground,
                                            selectedTextColor: UIColors.white,
                                            isSelected: orderScreenController
                                                .discountTypesSelection
                                                .value[discountType]!,
                                            onTap: () {
                                              orderScreenController
                                                  .setDiscountType(
                                                      discountType);
                                            },
                                          ))
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        ),
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
                    items: orderScreenController.orderStatus
                        .map((orderState) => RadioButtonItem(
                              text: orderState,
                              selectionColor: UIColors.primary,
                              selectedTextColor: UIColors.white,
                              isSelected: orderScreenController
                                  .orderStatusSelection.value[orderState]!,
                              onTap: () {
                                orderScreenController
                                    .setOrderStatus(orderState);
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
                controller: TextEditingController(),
                maxLines: 5,
                hintText: 'شب التوصيل: حسام',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
