import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earn_expense_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earn_expense_screen_controller.dart';
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

class CreateEarnExpenseScreen extends StatelessWidget {
  CreateEarnExpenseScreen({super.key});

  final accountsController = Get.find<AccountsController>();
  final earnExpenseScreenController = Get.put(EarnExapenseScreenController());
  final earnExpenseController = Get.find<EarnExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إيراد | مصروف'),
                spacerHeight(height: 22),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder(
                            init: earnExpenseScreenController,
                            builder: (context) {
                              return CustomRadioGroup(
                                height: 100,
                                childAspectRatio: 1.8,
                                items: [
                                  IconRadioItem(
                                    icon: FontAwesomeIcons.solidCircleDown,
                                    text: earnExpenseScreenController
                                        .statementTypes[0]
                                        .toString(),
                                    isSelected: earnExpenseScreenController
                                            .statementTypeSelection[
                                        earnExpenseScreenController
                                            .statementTypes[0]]!,
                                    onTap: () {
                                      earnExpenseScreenController
                                          .changeStatementType(
                                              earnExpenseScreenController
                                                  .statementTypes[0]);

                                      earnExpenseController.setStatementType(
                                          earnExpenseScreenController
                                              .statementTypes[0]);
                                    },
                                  ),
                                  IconRadioItem(
                                    icon: FontAwesomeIcons.solidCircleUp,
                                    text: earnExpenseScreenController
                                        .statementTypes[1]
                                        .toString(),
                                    isSelected: earnExpenseScreenController
                                            .statementTypeSelection[
                                        earnExpenseScreenController
                                            .statementTypes[1]]!,
                                    onTap: () {
                                      earnExpenseScreenController
                                          .changeStatementType(
                                              earnExpenseScreenController
                                                  .statementTypes[1]);

                                      earnExpenseController.setStatementType(
                                          earnExpenseScreenController
                                              .statementTypes[1]);
                                    },
                                  ),
                                ],
                              );
                            }),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'البيان'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller:
                              earnExpenseController.statementTextController,
                          keyboardType: TextInputType.text,
                          hintText: 'أدخل بيان القيد (اختياري)',
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'المبلغ'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: earnExpenseController.amountController,
                          keyboardType: TextInputType.number,
                          hintText: 'المبلغ الابتدائي 0',
                        ),
                        spacerHeight(height: 32),
                        const SectionTitle(title: 'إختر الصندوق'),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller:
                                    earnExpenseController.bankController,
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
                                earnExpenseController.setBankAccount(account);
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'تاريخ القيد'),
                        spacerHeight(),
                        CustomTextFormField(
                          readOnly: true,
                          controller: earnExpenseController.dateController,
                          keyboardType: TextInputType.datetime,
                          style: UITextStyle.normalBody,
                          suffix: InkWell(
                            onTap: () async {
                              earnExpenseScreenController.selectDate(
                                  await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.parse(
                                          earnExpenseController
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
                        spacerHeight(),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  return AcceptButton(
                    text: 'حفظ',
                    onPressed: () {
                      earnExpenseController.createStatementBasesOnType();
                    },
                    isLoading: earnExpenseController.loading.value,
                  );
                }),
                spacerHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
