import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateStatementScreen extends StatelessWidget {
  const CreateStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: const CustomDrawer(),
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
                              const Expanded(
                                child: CustomDropdownFormField(
                                  items: ['الصندوق'],
                                ),
                              ),
                              spacerWidth(),
                              CustomIconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: UIColors.mainIcon,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'إلى الحساب'),
                          spacerHeight(),
                          Row(
                            children: [
                              const Expanded(
                                child: CustomDropdownFormField(
                                  items: ['الزبون علي'],
                                ),
                              ),
                              spacerWidth(),
                              CustomIconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: UIColors.mainIcon,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'مبلغ القيد'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.number,
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'تاريخ القيد'),
                          spacerHeight(),
                          TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            decoration: textFieldStyle.copyWith(
                              suffixIcon: const Icon(
                                Icons.date_range,
                                color: UIColors.white,
                              ),
                            ),
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'البيان'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            hintText: 'تسجيل دفعة نقدية من الزبون علي',
                          ),
                          spacerHeight(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'نتيجة القيد: ',
                                  style: UITextStyle.normalBody
                                      .copyWith(height: 1.5),
                                ),
                                TextSpan(
                                  text:
                                      ' سيتم إضافة مبلغ 00000 إلى حساب الصندوق  وخصم مبلغ 00000 من حساب علي.',
                                  style: UITextStyle.normalBody.copyWith(
                                    height: 1.5,
                                    color: UIColors.normalText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
