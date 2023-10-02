import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/account_screen_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/success_saving_options_menu.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_image_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

import '../../BussinessLayer/Controllers/accounts_controller.dart';

class CreateEditAccountScreen extends StatelessWidget {
  CreateEditAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());
  final AccountsController accountsController = Get.find<AccountsController>();
  final AccountScreenController accountScreenController =
      Get.put(AccountScreenController());
  final homeController = Get.find<HomeController>();
  final Account? account = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (account != null) {
      accountScreenController.setAccountType(
          accountController.convertAccountTypeToString(account!.type));
    } else {
      if (accountsController.swapStyle != "" &&
          accountsController.swapStyle != null) {
        accountController.changeAccountStyle(accountsController.swapStyle);
        print('changing  ${accountsController.swapStyle!}');
      } else {
        //accountController.changeAccountStyle("حساب عادي");
      }
    }
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
                    const Expanded(
                      child: PageTitle(title: 'إنشاء | تعديل حساب'),
                    ),
                    if (account != null)
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              accountController
                                  .pinAccountToHomeScreen(account!.id);
                            },
                            child: const Icon(Icons.pin_invoke,
                                size: 30,
                                color: UIColors.primary,
                                semanticLabel: "ثتبيت"),
                          ),
                          spacerWidth(),
                          InkWell(
                            onTap: () {
                              Get.dialog(
                                CustomDialog(
                                  title: 'هل تريد حذف الحساب؟',
                                  acceptButton: Obx(() {
                                    return AcceptButton(
                                      text: 'حذف',
                                      backgroundColor: UIColors.red,
                                      onPressed: () async {
                                        await accountController
                                            .deleteAccount(account!.id);
                                        Get.until((route) =>
                                            route.settings.name ==
                                            AppRoutes.chooseAccountScreen);
                                      },
                                      isLoading:
                                          accountController.loading.value,
                                    );
                                  }),
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
                                hintText:
                                    'رصيد الحساب الإبتدائي ( الافتراضي 0 ) ',
                                formatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                              ),
                              spacerHeight(height: 20),
                              const SectionTitle(title: 'نمط الحساب'),
                              spacerHeight(),
                              Obx(
                                () {
                                  return CustomRadioGroup(
                                    items: [
                                      RadioButtonItem(
                                          text: accountScreenController
                                              .accountTypes[0],
                                          isSelected: accountScreenController
                                                  .accountTypesSelection[
                                              accountScreenController
                                                  .accountTypes[0]]!,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            accountScreenController
                                                .setAccountType(
                                                    accountScreenController
                                                        .accountTypes[0]);
                                            accountController.setAccountType(
                                                accountScreenController
                                                    .accountTypes[0]);
                                          }),
                                      RadioButtonItem(
                                          text: accountScreenController
                                              .accountTypes[1],
                                          isSelected: accountScreenController
                                                  .accountTypesSelection[
                                              accountScreenController
                                                  .accountTypes[1]]!,
                                          selectionColor: UIColors.white,
                                          selectedTextColor: UIColors.menuTitle,
                                          onTap: () {
                                            accountScreenController
                                                .setAccountType(
                                                    accountScreenController
                                                        .accountTypes[1]);
                                            accountController.setAccountType(
                                                accountScreenController
                                                    .accountTypes[1]);
                                          }),
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
                                  'مورد',
                                  'جهة عمل',
                                  'مسوق'
                                ],
                                onChanged: (value) {
                                  if ([
                                    'حساب عادي',
                                    'صندوق',
                                    'جهة عمل',
                                  ].contains(value)) {
                                    accountScreenController
                                        .setAccountType('مدين');
                                  } else {
                                    accountScreenController
                                        .setAccountType('دائن');
                                  }
                                  accountScreenController
                                      .changeAccountStyleForInformation(value);
                                  accountController.setAccountStyle(value);
                                },
                              ),
                              spacerHeight(),
                              GetBuilder(
                                  init: accountScreenController,
                                  builder: (context) {
                                    return accountController
                                            .accountStyleForInformation
                                        ? Column(
                                            children: [
                                              CustomTextFormField(
                                                controller: accountController
                                                    .emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                hintText: 'البريد الالكتروني',
                                              ),
                                              spacerHeight(),
                                              CustomTextFormField(
                                                controller: accountController
                                                    .mobilePhoneController,
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: 'الرقم',
                                                formatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'^\d+\.?\d{0,2}'))
                                                ],
                                              ),
                                              spacerHeight(),
                                              CustomTextFormField(
                                                controller: accountController
                                                    .addressController,
                                                keyboardType:
                                                    TextInputType.streetAddress,
                                                hintText: 'العنوان',
                                              ),
                                              spacerHeight(),
                                              Obx(() {
                                                return accountScreenController
                                                        .selectedAccountImage
                                                        .value
                                                        .isEmpty
                                                    ? account != null &&
                                                            account!.avatar!
                                                                .isNotEmpty
                                                        ? CustomImageContainer(
                                                            image: NetworkImage(
                                                                account!.avatar
                                                                    .toString()),
                                                          )
                                                        : Container()
                                                    : CustomImageContainer(
                                                        image: FileImage(File(
                                                            accountScreenController
                                                                .selectedAccountImage
                                                                .value)),
                                                      );
                                              }),
                                              spacerHeight(),
                                              AcceptIconButton(
                                                center: true,
                                                text: Text(
                                                  'صورة الحساب',
                                                  style: UITextStyle.normalBody
                                                      .copyWith(
                                                    color: UIColors.menuTitle,
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  FontAwesomeIcons.images,
                                                  size: 20,
                                                  color: UIColors.mainIcon,
                                                ),
                                                backgroundColor: UIColors.white,
                                                onPressed: () async {
                                                  accountScreenController
                                                      .selectAccountImage();
                                                },
                                              ),
                                            ],
                                          )
                                        : Container();
                                  })
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
                    onPressed: () async {
                      accountController.setSelectedAccountImage(
                          accountScreenController.selectedAccountImage.value);
                      if (account != null) {
                        await accountController.updateAccount(account!.id);
                      } else {
                        await accountController.createAccount();
                        if (accountController.savingState) {
                          Get.dialog(
                            const SuccessSavingOptionsMenu(
                              createButtonText: 'إنشاء حساب جديد',
                            ),
                          );
                        }
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
