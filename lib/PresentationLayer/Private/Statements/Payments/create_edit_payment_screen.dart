import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/icon_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

// ignore: must_be_immutable
class CreateEditPaymentScreen extends StatelessWidget {
  CreateEditPaymentScreen({super.key});

  final paymentController = Get.put(PaymentController());
  final paymentScreenController = Get.put(PaymentScreenController());
  final accountsController = Get.find<AccountsController>();

  var paymentType = Get.arguments;

  @override
  Widget build(BuildContext context) {
    paymentScreenController.setPaymentType(paymentType);
    paymentController.setPaymentType(paymentType);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إنشاء | تعديل دفعة'),
                spacerHeight(height: 22),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder(
                            init: paymentScreenController,
                            builder: (context) {
                              return CustomRadioGroup(
                                height: 100,
                                childAspectRatio: 1.8,
                                items: [
                                  IconRadioItem(
                                    icon: FontAwesomeIcons.solidCircleDown,
                                    text: paymentScreenController
                                        .paymentTypes[0]
                                        .toString(),
                                    isSelected: paymentScreenController
                                            .paymentTypesSelection[
                                        paymentScreenController
                                            .paymentTypes[0]]!,
                                    onTap: () {
                                      paymentScreenController.changePaymentType(
                                          paymentScreenController
                                              .paymentTypes[0]);

                                      paymentController.setPaymentType(
                                          paymentScreenController
                                              .paymentTypes[0]);
                                    },
                                  ),
                                  IconRadioItem(
                                    icon: FontAwesomeIcons.solidCircleUp,
                                    text: paymentScreenController
                                        .paymentTypes[1]
                                        .toString(),
                                    isSelected: paymentScreenController
                                            .paymentTypesSelection[
                                        paymentScreenController
                                            .paymentTypes[1]]!,
                                    onTap: () {
                                      paymentScreenController.changePaymentType(
                                          paymentScreenController
                                              .paymentTypes[1]);

                                      paymentController.setPaymentType(
                                          paymentScreenController
                                              .paymentTypes[1]);
                                    },
                                  ),
                                ],
                              );
                            }),
                        spacerHeight(height: 30),
                        const SectionTitle(title: 'إختر الصندوق'),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller: paymentController.bankController,
                                hintText: 'الصندوق',
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
                                      'accounts':
                                          accountsController.bankAccounts
                                    });
                                paymentController.setBankAccount(account);
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 30),
                        const SectionTitle(title: 'الطرف المقابل'),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller:
                                    paymentController.counterPartyController,
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
                                      'accounts':
                                          accountsController.customersAccounts
                                    });
                                paymentController
                                    .setCounterPartyAccount(account);
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 30),
                        const SectionTitle(title: 'مبلغ الدفعة'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: paymentController.amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          hintText: 'أدخل المبلغ',
                          formatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                          onChanged: (amount) {
                            paymentController.setAmount(amount);
                          },
                        ),
                        spacerHeight(height: 30),
                        const SectionTitle(title: 'تاريخ الدفعة'),
                        spacerHeight(),
                        CustomTextFormField(
                          readOnly: true,
                          controller: paymentController.dateController,
                          keyboardType: TextInputType.datetime,
                          style: UITextStyle.normalBody,
                          suffix: InkWell(
                            onTap: () async {
                              paymentScreenController.selectDate(
                                  await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.parse(
                                          paymentController
                                              .dateController.text),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)));
                            },
                            child: const Icon(
                              Icons.date_range,
                              color: UIColors.white,
                            ),
                          ),
                        ),
                        spacerHeight(height: 20),
                        const SectionTitle(title: 'ملاحظات'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: paymentController.notesController,
                          maxLines: 5,
                          hintText: 'شب التوصيل: حسام',
                        ),
                      ],
                    ),
                  ),
                ),
                spacerHeight(),
                Obx(() {
                  return AcceptButton(
                    text: 'حفظ',
                    onPressed: () {
                      paymentController.createPayment();
                    },
                    isLoading: paymentController.loading.value,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
