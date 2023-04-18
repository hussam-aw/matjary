import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/primary_line.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

import '../../BussinessLayer/Controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 90),
            child: Column(
              children: [
                const AppIconHeader(),
                Expanded(
                  flex: 3,
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: authController.loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'اسم المستخدم',
                        ),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: authController.loginPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'كلمة المرور',
                        ),
                        spacerHeight(),
                        AcceptButton(
                          onPressed: () async {
                            await authController.login();
                          },
                          text: 'متابعة',
                        ),
                        spacerHeight(),
                        AcceptButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.registerScreen);
                          },
                          style: acceptButtonWithBorderStyle,
                          text: 'إنشاء حساب',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: const PrimaryLine(),
      ),
    );
  }
}
