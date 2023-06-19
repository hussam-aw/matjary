import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              children: [
                const AppIconHeader(),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: TextEditingController(),
                            hintText: 'الاسم',
                          ),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.phone,
                            hintText: 'رقم الهاتف',
                          ),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.visiblePassword,
                            obsecureText: true,
                            hintText: 'كلمة المرور',
                          ),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.visiblePassword,
                            obsecureText: true,
                            hintText: 'تأكيد كلمة المرور',
                          ),
                          spacerHeight(),
                          AcceptButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.pinCodeScreen);
                            },
                            text: 'إنشاء حساب',
                          ),
                          spacerHeight(),
                          AccetpIconButton(
                            onPressed: () {},
                            center: true,
                            icon: const Icon(FontAwesomeIcons.squareFacebook),
                            text: Text(
                              'متابعة باستخدام الفيسبوك',
                              style: UITextStyle.boldMeduim
                                  .copyWith(color: UIColors.white),
                            ),
                          ),
                          spacerHeight(),
                          AccetpIconButton(
                            onPressed: () {},
                            backgroundColor: UIColors.white,
                            center: true,
                            icon: const Icon(
                              FontAwesomeIcons.google,
                              color: UIColors.primary,
                            ),
                            text: Text(
                              'متابعة باستخدام غوغل',
                              style: UITextStyle.boldMeduim
                                  .copyWith(color: UIColors.darkText),
                            ),
                          ),
                        ],
                      ),
                    ),
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
