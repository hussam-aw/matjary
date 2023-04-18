import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateEditAccountScreen extends StatelessWidget {
  const CreateEditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إنشاء | تعديل حساب'),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle(title: 'المعلومات الأساسية'),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.name,
                              hintText: 'اسم الحساب',
                            ),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              hintText: 'المبلغ الإبتدائي ( الجرد الأولي )',
                            ),
                            spacerHeight(height: 20),
                            const SectionTitle(title: 'نمط الحساب'),
                            spacerHeight(),
                            CustomRadioButton(
                              items: [
                                RadioButtonItem(
                                    text: 'مدين',
                                    isSelected: true,
                                    onTap: () {}),
                                RadioButtonItem(text: 'دائن', onTap: () {})
                              ],
                            ),
                            spacerHeight(height: 20),
                            const SectionTitle(title: 'نوع الحساب'),
                            spacerHeight(),
                            const CustomDropdownFormField(
                              items: ['حساب عادي', 'صندوق', 'جهة عمل'],
                            ),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'البريد الالكتروني',
                            ),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              hintText: 'الرقم',
                            ),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.streetAddress,
                              hintText: 'العنوان',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                spacerHeight(height: 30),
                AcceptButton(
                  text: 'إنشاء',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
