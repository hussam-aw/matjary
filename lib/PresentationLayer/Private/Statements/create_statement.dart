import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateStatementScreen extends StatelessWidget {
  CreateStatementScreen({super.key});

  final homeController = Get.find<HomeController>();
  final StatementController statementController =
      Get.put(StatementController());
  final StatementScreenController statementScreenController =
      Get.put(StatementScreenController());
  final AccountsController accountsController = Get.find<AccountsController>();

  // Widget productSelectionDialog(String type) {
  //   return AlertDialog(
  //     backgroundColor: UIColors.mainBackground,
  //     content: SizedBox(
  //       height: 500,
  //       width: Get.width,
  //       child: ListView.separated(
  //         scrollDirection: Axis.vertical,
  //         itemBuilder: (context, index) {
  //           return NormalBox(
  //             title: homeController.accounts[index].name,
  //             onTap: () {
  //               type == "from"
  //                   ? statementController.setFromAccountInDropdownButton(
  //                       homeController.accounts[index].name,
  //                     )
  //                   : statementController.setToAccountInDropdownButton(
  //                       homeController.accounts[index].name,
  //                     );
  //               Get.back();
  //             },
  //           );
  //         },
  //         separatorBuilder: (context, index) {
  //           return const SizedBox(height: 15);
  //         },
  //         itemCount: homeController.accounts.length,
  //       ),
  //     ),
  //   );
  // }

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
                const PageTitle(title: 'إنشاء | تعديل قيد محاسبي'),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'من الحساب'),
                          spacerHeight(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  readOnly: true,
                                  controller:
                                      statementController.fromAccountController,
                                  hintText: "الحساب",
                                ),
                              ),
                              spacerWidth(),
                              CustomIconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: UIColors.mainIcon,
                                ),
                                onPressed: () async {
                                  // Get.dialog(
                                  //   productSelectionDialog("from"),
                                  // );
                                  var account = await Get.toNamed(
                                      AppRoutes.chooseAccountScreen,
                                      arguments: {
                                        'mode': 'selection',
                                        'accounts': accountsController.accounts
                                      });

                                  statementController.setFromAccount(account);
                                },
                              ),
                            ],
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'إلى الحساب'),
                          spacerHeight(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  readOnly: true,
                                  controller:
                                      statementController.toAccountController,
                                  hintText: 'الحساب',
                                ),
                              ),
                              spacerWidth(),
                              CustomIconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: UIColors.mainIcon,
                                ),
                                onPressed: () async {
                                  // Get.dialog(
                                  //   productSelectionDialog("to"),
                                  // );
                                  var account = await Get.toNamed(
                                      AppRoutes.chooseAccountScreen,
                                      arguments: {
                                        'mode': 'selection',
                                        'accounts': accountsController.accounts
                                      });
                                  statementController.setToAccount(account);
                                },
                              ),
                            ],
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'مبلغ القيد'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: statementController.amountController,
                            keyboardType: TextInputType.number,
                            hintText: 'المبلغ الابتدائي 0',
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (amount) {
                              statementController.setAmount(amount);
                            },
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'تاريخ القيد'),
                          spacerHeight(),
                          CustomTextFormField(
                            readOnly: true,
                            controller: statementController.dateController,
                            keyboardType: TextInputType.datetime,
                            style: UITextStyle.normalBody,
                            suffix: InkWell(
                              onTap: () async {
                                statementScreenController.selectDate(
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.parse(
                                            statementController
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
                          const SectionTitle(title: 'البيان'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller:
                                statementController.statementTextController,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            hintText: 'تسجيل دفعة نقدية من الزبون ',
                          ),
                          spacerHeight(),
                          Obx(() {
                            return statementController
                                        .fromAccountName.value.isNotEmpty &&
                                    statementController
                                        .toAccountName.value.isNotEmpty &&
                                    statementController
                                        .statementAmount.value.isNotEmpty
                                ? RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'نتيجة القيد: ',
                                          style: UITextStyle.normalBody
                                              .copyWith(height: 1.5),
                                        ),
                                        TextSpan(
                                          text:
                                              ' سيتم إضافة مبلغ ${statementController.statementAmount.value} إلى حساب ${statementController.toAccountName.value}  وخصم مبلغ ${statementController.statementAmount.value} من حساب ${statementController.fromAccountName.value}.',
                                          style:
                                              UITextStyle.normalBody.copyWith(
                                            height: 1.5,
                                            color: UIColors.normalText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                spacerHeight(height: 30),
                Obx(() {
                  return AcceptButton(
                    text: 'إنشاء',
                    onPressed: () {
                      statementController.createStatement();
                    },
                    isLoading: statementController.loading.value,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
