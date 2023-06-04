import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
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

class CreateEditPaymentScreen extends StatelessWidget {
  CreateEditPaymentScreen({super.key});

  final paymentController = Get.put(PaymentController());
  final paymentScreenController = Get.put(PaymentScreenController());
  final accountsController = Get.find<AccountsController>();

  @override
  Widget build(BuildContext context) {
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
                                items:
                                    paymentScreenController.paymentTypes.values
                                        .map(
                                          (paymentType) => IconRadioItem(
                                            icon: Ionicons.happy,
                                            text: paymentType,
                                            isSelected: paymentScreenController
                                                    .paymentTypesSelection[
                                                paymentType]!,
                                            onTap: () {
                                              paymentScreenController
                                                  .setPaymentType(paymentType);

                                              paymentController
                                                  .setPaymentType(paymentType);
                                            },
                                          ),
                                        )
                                        .toList(),
                              );
                            }),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'إختر الصندوق'),
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
                        SectionTitle(title: 'الطرف المقابل'),
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
                                      'style': 'clientsAndSuppliers',
                                      'accounts': accountsController
                                          .clientAndSupplierAccounts
                                    });
                                paymentController
                                    .setCounterPartyAccount(account);
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'مبلغ الدفعة'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: paymentController.amountController,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          formatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                          onChanged: (amount) {
                            paymentController.setAmount(amount);
                          },
                        ),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'تاريخ الدفعة'),
                        spacerHeight(),
                        TextFormField(
                          readOnly: true,
                          controller: paymentController.dateController,
                          keyboardType: TextInputType.datetime,
                          style: UITextStyle.normalBody,
                          decoration: textFieldStyle.copyWith(
                              suffixIcon: IconButton(
                            onPressed: () async {
                              paymentScreenController.selectDate(
                                  await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.parse(
                                          paymentController
                                              .dateController.text),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)));
                            },
                            icon: const Icon(
                              Icons.date_range,
                              color: UIColors.white,
                            ),
                          )),
                        ),
                        spacerHeight(height: 20),
                        SectionTitle(title: 'ملاحظات'),
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
