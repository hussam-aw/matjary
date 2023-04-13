import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
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
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 90),
            child: Column(
              children: [
                const AppIconHeader(),
                Expanded(
                  flex: 3,
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: authController.loginEmailController,
                          keyboardType: TextInputType.name,
                          decoration: textFieldStyle.copyWith(
                            hintText: 'اسم المستخدم',
                          ),
                        ),
                        spacerHeight(),
                        TextFormField(
                          controller: authController.loginPasswordController,
                          keyboardType: TextInputType.name,
                          decoration: textFieldStyle.copyWith(
                            hintText: 'كلمة المرور',
                          ),
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
