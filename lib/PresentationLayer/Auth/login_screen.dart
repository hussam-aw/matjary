import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/primary_line.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

import '../../BussinessLayer/Controllers/auth_controller.dart';
import '../../Constants/ui_text_styles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: UIColors.mainBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
            child: GetBuilder(
                init: authController,
                builder: (context) {
                  return Column(
                    children: [
                      const AppIconHeader(),
                      const Text(
                        "تسجيل الدخول ",
                        style: UITextStyle.boldHeading,
                      ),
                      Expanded(
                        flex: 3,
                        child: Form(
                          child: Column(
                            children: [
                              spacerHeight(
                                height: 30,
                              ),
                              CustomTextFormField(
                                controller: authController.loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'اسم المستخدم',
                              ),
                              spacerHeight(),
                              CustomTextFormField(
                                controller:
                                    authController.loginPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obsecureText: true,
                                hintText: 'كلمة المرور',
                              ),
                              spacerHeight(),
                              Obx(() {
                                return AcceptButton(
                                  text: 'متابعة',
                                  onPressed: () async {
                                    await authController.login();
                                  },
                                  isLoading: authController.logging.value,
                                );
                              }),
                              /* spacerHeight(),
                              AcceptButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.registerScreen);
                                },
                                backgroundColor: UIColors.primary,
                                text: 'إنشاء حساب',
                              ), */
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
        bottomSheet: const PrimaryLine(),
      ),
    );
  }
}
