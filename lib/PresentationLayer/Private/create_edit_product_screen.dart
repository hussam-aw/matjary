import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateEditProductScreen extends StatelessWidget {
  const CreateEditProductScreen({super.key});

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
                const PageTitle(title: 'إنشاء | تعديل منتج'),
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
                                hintText: 'اسم المنتج',
                              ),
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'رقم الموديل',
                              ),
                            ),
                            spacerHeight(),
                            Row(
                              children: [
                                const Expanded(
                                  child: CustomDropdownFormField(
                                    items: ['تابع لتصنيف'],
                                  ),
                                ),
                                spacerWidth(),
                                CustomIconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    color: UIColors.mainIcon,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            spacerHeight(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: textFieldStyle.copyWith(
                                hintText: 'الكمية الإبتدائية ( الجرد الأولي )',
                              ),
                            ),
                            spacerHeight(height: 22),
                            const SectionTitle(title: 'يتأثر بتغيرات الصرف'),
                            spacerHeight(),
                            CustomRadioButton(
                              items: [
                                RadioButtonItem(
                                    text: 'يتأثر',
                                    isSelected: true,
                                    onTap: () {}),
                                RadioButtonItem(text: 'لا يتأثر', onTap: () {})
                              ],
                            ),
                            spacerHeight(height: 22),
                            const SectionTitle(title: 'أسعار البيع'),
                            spacerHeight(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textFieldStyle.copyWith(
                                      hintText: 'الجملة',
                                    ),
                                  ),
                                ),
                                spacerWidth(),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textFieldStyle.copyWith(
                                      hintText: 'الموزع',
                                    ),
                                  ),
                                ),
                                spacerWidth(),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textFieldStyle.copyWith(
                                      hintText: 'المفرق',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            spacerHeight(),
                            AccetpIconButton(
                              center: true,
                              text: Text(
                                'صور المنتج',
                                style: UITextStyle.normalBody.copyWith(
                                  color: UIColors.menuTitle,
                                ),
                              ),
                              icon: const Icon(
                                FontAwesomeIcons.images,
                                size: 20,
                                color: UIColors.mainIcon,
                              ),
                              backgroundColor: UIColors.white,
                              onPressed: () {},
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
