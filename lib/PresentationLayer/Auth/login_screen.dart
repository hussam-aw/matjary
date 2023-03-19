import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 90),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 163,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: authInputStyle.copyWith(
                          hintText: 'اسم المستخدم',
                        ),
                      ),
                      spacerHeight(),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: authInputStyle.copyWith(
                          hintText: 'كلمة المرور',
                        ),
                      ),
                      spacerHeight(),
                      ElevatedButton(
                        onPressed: () {},
                        style: acceptButtonStyle,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'متابعة',
                            style: UITextStyle.boldMeduim,
                          ),
                        ),
                      ),
                      spacerHeight(),
                      ElevatedButton(
                        onPressed: () {},
                        style: acceptButtonWithBorderStyle,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'انشاء حساب',
                            style: UITextStyle.boldMeduim,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: const PrimaryLine(),
      ),
    );
  }
}
