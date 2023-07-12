import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const CreateEditUserScreen({super.key});

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
                        CustomRadioGroup(
                          items: [
                            RadioButtonItem(
                              text: 'مسؤول',
                              isSelected: true,
                              borderExist: true,
                              onTap: () {},
                            ),
                            RadioButtonItem(
                              text: 'محرر',
                              isSelected: false,
                              borderExist: false,
                              onTap: () {},
                            )
                          ],
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'اسم المستخدم'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: TextEditingController(),
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
                          controller: TextEditingController(),
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
                          controller: TextEditingController(),
                          hintText: 'أدخل كلمة المرور',
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'تتبع الحركة'),
                        spacerHeight(),
                        CustomRadioGroup(
                          items: [
                            RadioButtonItem(
                              text: 'استلام اشعارات',
                              isSelected: true,
                              borderExist: true,
                              onTap: () {},
                            ),
                            RadioButtonItem(
                              text: 'بدون اشعارات',
                              isSelected: false,
                              borderExist: false,
                              onTap: () {},
                            )
                          ],
                        ),
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
                AcceptButton(
                  text: 'حفظ',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
