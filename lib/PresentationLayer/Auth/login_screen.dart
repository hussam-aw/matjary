import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/primary_line.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                          keyboardType: TextInputType.name,
                          decoration: textFieldStyle.copyWith(
                            hintText: 'اسم المستخدم',
                          ),
                        ),
                        spacerHeight(),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: textFieldStyle.copyWith(
                            hintText: 'كلمة المرور',
                          ),
                        ),
                        spacerHeight(),
                        AcceptButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.homeScreen);
                          },
                          text: 'متابعة',
                        ),
                        spacerHeight(),
                        AcceptButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.registerscreen);
                          },
                          style: acceptButtonWithBorderStyle,
                          text: 'انشاء حساب',
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
