import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/user_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/user_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateEditUserScreen extends StatelessWidget {
  CreateEditUserScreen({super.key});

  final userScreenController = Get.put(UserScreenController());
  final userController = Get.put(UserController());

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
                const PageTitle(title: 'إنشاء | تعديل مستخدم'),
                spacerHeight(height: 22),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return CustomRadioGroup(
                            items: userScreenController.userTypes
                                .map(
                                  (type) => RadioButtonItem(
                                    text: type,
                                    isSelected: userScreenController
                                        .userTypesSelection[type]!,
                                    borderExist: true,
                                    onTap: () {
                                      userScreenController.setUserType(type);
                                      userController.setUserType(type);
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        }),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'اسم المستخدم'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: userController.userNameController,
                          hintText: 'أدخل اسم المستخدم',
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(
                          title: 'بيانات الدخول',
                          textStyle: UITextStyle.normalMeduim,
                          titleColor: UIColors.white,
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'رقم الموبايل'),
                        spacerHeight(),
                        CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: userController.mobileNumberController,
                          hintText: 'أدخل رقم الموبايل',
                          formatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'كلمة المرور'),
                        spacerHeight(),
                        CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: userController.passwordController,
                          hintText: 'أدخل كلمة المرور',
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'تتبع الحركة'),
                        spacerHeight(),
                        Obx(() {
                          return CustomRadioGroup(
                              items: userScreenController.notifiableTypes
                                  .map((type) => RadioButtonItem(
                                        text: type,
                                        isSelected: userScreenController
                                            .notifiableTypesSelection[type]!,
                                        borderExist: true,
                                        onTap: () {
                                          userScreenController
                                              .setNotifiableType(type);
                                          userController
                                              .setNotifiableType(type);
                                        },
                                      ))
                                  .toList());
                        }),
                        spacerHeight(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'ستصلك إشعارات عن كل حركة قام بها المستخدم',
                            style: UITextStyle.normalSmall.copyWith(
                              color: UIColors.normalText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //spacerHeight(height: 22),
                Obx(
                  () {
                    return AcceptButton(
                      text: 'حفظ',
                      onPressed: () {
                        userController.createUser();
                      },
                      isLoading: userController.isLoading.value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
