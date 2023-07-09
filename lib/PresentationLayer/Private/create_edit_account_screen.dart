import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/account_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateEditAccountScreen extends StatelessWidget {
  CreateEditAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());
  final AccountScreenController accountScreenController =
      Get.put(AccountScreenController());
  final Account? account = Get.arguments;

  @override
  Widget build(BuildContext context) {
    accountController.setAcountDetails(account);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const PageTitle(title: 'إنشاء | تعديل حساب'),
                    ),
                    if (account != null)
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                              title: 'هل تريد حذف الحساب؟',
                              buttonText: 'حذف',
                              confirmOnPressed: () async {
                                await accountController
                                    .deleteAccount(account!.id);
                                Get.until((route) =>
                                    route.settings.name ==
                                    AppRoutes.chooseAccountScreen);
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: UIColors.primary,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GetBuilder(
                        init: accountController,
                        builder: (context) => Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle(title: 'المعلومات الأساسية'),
                              spacerHeight(),
                              CustomTextFormField(
                                controller: accountController.nameController,
                                keyboardType: TextInputType.name,
                                hintText: 'اسم الحساب',
                              ),
                              spacerHeight(),
                              CustomTextFormField(
                                controller: accountController.balanceController,
                                keyboardType: TextInputType.number,
                                hintText: 'المبلغ الإبتدائي ( الجرد الأولي )',
                              ),
                              spacerHeight(height: 20),
                              const SectionTitle(title: 'نمط الحساب'),
                              spacerHeight(),
                              GetBuilder(
                                init: accountScreenController,
                                builder: (context) {
                                  accountScreenController
                                      .setAccountType(accountController.type);
                                  return CustomRadioGroup(
                                    items: [
                                      RadioButtonItem(
                                          text: 'مدين',
                                          isSelected:
                                              accountScreenController.debtor,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            accountController.type = 'مدين';
                                            accountScreenController
                                                .changeAccountType('مدين');
                                          }),
                                      RadioButtonItem(
                                          text: 'دائن',
                                          isSelected:
                                              accountScreenController.creditor,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            accountController.type = 'دائن';
                                            accountScreenController
                                                .changeAccountType('دائن');
                                          })
                                    ],
                                  );
                                },
                              ),
                              spacerHeight(height: 20),
                              const SectionTitle(title: 'نوع الحساب'),
                              spacerHeight(),
                              CustomDropdownFormField(
                                value: accountController.style,
                                items: const [
                                  'حساب عادي',
                                  'صندوق',
                                  'زبون',
                                  'مزود',
                                  'جهة عمل',
                                  'مسوق'
                                ],
                                onChanged: (value) {
                                  accountController.style = value;
                                },
                              ),
                              spacerHeight(),
                              CustomTextFormField(
                                controller: accountController.emailController,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'البريد الالكتروني',
                              ),
                              spacerHeight(),
                              CustomTextFormField(
                                controller:
                                    accountController.mobilePhoneController,
                                keyboardType: TextInputType.number,
                                hintText: 'الرقم',
                              ),
                              spacerHeight(),
                              CustomTextFormField(
                                controller: accountController.addressController,
                                keyboardType: TextInputType.streetAddress,
                                hintText: 'العنوان',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                spacerHeight(height: 30),
                Obx(
                  () => AcceptButton(
                    text: account != null ? "تعديل" : "إنشاء",
                    onPressed: () {
                      if (account != null) {
                        accountController.updateAccount(account!.id);
                      } else {
                        accountController.createAccount();
                      }
                    },
                    isLoading: accountController.loading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
