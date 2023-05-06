import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderBasicInformationScreen extends StatelessWidget {
  OrderBasicInformationScreen({super.key});

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
              const SectionTitle(title: 'نوع الفاتورة'),
              spacerHeight(),
              GetBuilder(
                init: orderScreenController,
                builder: (context) {
                  return SizedBox(
                    height: 45,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return RadioButtonItem(
                          text: orderScreenController.orderTypes[index],
                          selectionColor: UIColors.primary,
                          selectedTextColor: UIColors.white,
                          isSelected: orderScreenController.orderSelection[
                              orderScreenController.orderTypes[index]]!,
                          onTap: () {
                            orderScreenController.changeOrderType(
                                orderScreenController.orderTypes[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => spacerWidth(),
                      itemCount: 5,
                    ),
                  );
                },
              ),
              spacerHeight(height: 22),
              const SectionTitle(title: 'الطرف المقابل ( زبون أو مورد )'),
              spacerHeight(),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    readOnly: true,
                    controller: TextEditingController(),
                    hintText: 'الزبون',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    heroTag: "to",
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              spacerHeight(height: 22),
              const SectionTitle(title: 'الصندوق ( النقدية )'),
              spacerHeight(),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    readOnly: true,
                    controller: TextEditingController(),
                    hintText: 'صندوق المحل',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    heroTag: "to",
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              spacerHeight(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'سيتم إيداع أو سحب قيمة صافي الفاتورة منه أو إليه  ',
                  style: UITextStyle.normalBody.copyWith(
                    color: UIColors.normalText,
                  ),
                ),
              ),
              spacerHeight(height: 22),
              const SectionTitle(title: 'المستودع'),
              spacerHeight(),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    readOnly: true,
                    controller: TextEditingController(),
                    hintText: 'الرئيسي',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    heroTag: "to",
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              spacerHeight(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'سيتم زيادة أو تقليص المنتجات من المستودع المختار',
                  style: UITextStyle.normalBody.copyWith(
                    color: UIColors.normalText,
                  ),
                ),
              ),
              spacerHeight(height: 22),
              const SectionTitle(title: 'حساب المسوق ( المندوب )'),
              spacerHeight(),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    readOnly: true,
                    controller: TextEditingController(),
                    hintText: 'لا يوجد مسوق',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    heroTag: "to",
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () {},
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
