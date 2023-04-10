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
            width: Get.width,
            height: Get.height,
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
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'اسم الحساب',
                              ),
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'المبلغ الإبتدائي ( الجرد الأولي )',
                              ),
                            ),
                            spacerHeight(height: 22),
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
                            spacerHeight(height: 22),
                            const SectionTitle(title: 'نوع الحساب'),
                            spacerHeight(),
                            const CustomDropdownFormField(
                              items: ['حساب عادي', 'صندوق', 'جهة عمل'],
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'البريد الالكتروني',
                              ),
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'الرقم',
                              ),
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.streetAddress,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'العنوان',
                              ),
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
