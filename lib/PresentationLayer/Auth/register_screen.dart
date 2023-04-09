import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                  flex: 6,
                  child: Form(
                    child: Column(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'الاسم',
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'رقم الهاتف',
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'كلمة المرور',
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'تأكيد كلمة المرور',
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: acceptButtonStyle,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'انشاء حساب',
                                style: UITextStyle.boldMeduim,
                              ),
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: acceptButtonStyle.copyWith(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      UIColors.buttonBackground),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(FontAwesomeIcons.squareFacebook),
                                  spacerWidth(),
                                  const Text(
                                    'متابعة باستخدام الفيسبوك',
                                    style: UITextStyle.boldMeduim,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        spacerHeight(),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: acceptButtonStyle.copyWith(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      UIColors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.google,
                                    color: UIColors.primary,
                                  ),
                                  spacerWidth(),
                                  Text(
                                    'متابعة باستخدام غوغل',
                                    style: UITextStyle.boldMeduim.copyWith(
                                      color: UIColors.darkText,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
