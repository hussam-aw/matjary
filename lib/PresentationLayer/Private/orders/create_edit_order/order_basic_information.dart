import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderBasicInformation extends StatelessWidget {
  OrderBasicInformation({super.key});

  final orderScreenController = Get.find<OrderScreenController>();
  final orderController = Get.find<OrderController>();
  final accountsController = Get.find<AccountsController>();

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
              Obx(
                () {
                  return CustomRadioGroup(
                    scrollDirection: Axis.horizontal,
                    items: orderScreenController.orderTypes.keys
                        .map((orderType) => RadioButtonItem(
                              text: orderType,
                              selectionColor: UIColors.primary,
                              selectedTextColor: UIColors.white,
                              isSelected: orderScreenController
                                  .orderTypesSelection.value[orderType]!,
                              onTap: () {
                                orderScreenController.setOrderType(orderType);
                                orderScreenController
                                    .updateSelectedProductsPrices();
                                orderController.setOrderType(
                                    orderScreenController
                                        .orderTypes[orderType]);
                                orderScreenController.setProductsPrices();
                              },
                            ))
                        .toList(),
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
                      controller: orderController.counterPartyController,
                      hintText: 'الزبون',
                    ),
                  ),
                  spacerWidth(),
                  CustomIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () async {
                      var account = await Get.toNamed(
                          AppRoutes.chooseAccountScreen,
                          arguments: {
                            'mode': 'selection',
                            'style': 'customers',
                            'accounts': accountsController.customersAccounts
                          });
                      orderScreenController.selectAccountBasedOnType(
                          account, 'customers');
                    },
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
                      controller: orderController.bankController,
                      hintText: 'صندوق المحل',
                    ),
                  ),
                  spacerWidth(),
                  CustomIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () async {
                      var account = await Get.toNamed(
                          AppRoutes.chooseAccountScreen,
                          arguments: {
                            'mode': 'selection',
                            'style': 'bank',
                            'accounts': accountsController.bankAccounts
                          });
                      orderScreenController.selectAccountBasedOnType(
                          account, 'bank');
                    },
                  ),
                ],
              ),
              spacerHeight(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'سيتم إيداع أو سحب قيمة صافي الفاتورة منه أو إليه  ',
                  style: UITextStyle.small.copyWith(
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
                    controller: orderController.wareController,
                    hintText: 'الرئيسي',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () async {
                      var ware = await Get.toNamed(
                        AppRoutes.chooseWareScreen,
                        arguments: {'mode': 'selection'},
                      );
                      orderScreenController.selectWare(ware);
                    },
                  ),
                ],
              ),
              spacerHeight(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'سيتم زيادة أو تقليص المنتجات من المستودع المختار',
                  style: UITextStyle.small.copyWith(
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
                    controller: orderController.marketerController,
                    hintText: 'لا يوجد مسوق',
                  )),
                  spacerWidth(),
                  CustomIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: UIColors.mainIcon,
                    ),
                    onPressed: () async {
                      var account = await Get.toNamed(
                          AppRoutes.chooseAccountScreen,
                          arguments: {
                            'mode': 'selection',
                            'style': 'marketer',
                            'accounts': accountsController.marketerAccounts
                          });
                      orderScreenController.selectAccountBasedOnType(
                          account, 'marketer');
                      if (orderController.marketerAccount == null) {
                        orderController.setMarketerDiscount(0.0);
                      }
                    },
                  ),
                ],
              ),
              spacerHeight(height: 22),
              const SectionTitle(title: 'تاريخ الانشاء'),
              spacerHeight(),
              TextFormField(
                readOnly: true,
                controller: orderController.dateController,
                keyboardType: TextInputType.datetime,
                style: UITextStyle.normalBody,
                decoration: textFieldStyle.copyWith(
                    suffixIcon: IconButton(
                  onPressed: () async {
                    orderScreenController.selectDate(
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(
                              orderController.dateController.text),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)),
                    );
                  },
                  icon: const Icon(
                    Icons.date_range,
                    color: UIColors.white,
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
