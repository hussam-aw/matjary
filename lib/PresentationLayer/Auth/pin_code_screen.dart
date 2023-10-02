import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_pincode_fields.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const AppIconHeader(),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * .6,
                          child: Text(
                            'لقد قمنا بإرسال رمز مكون من 5 أرقام قم بإدخاله لتأكيد الحساب',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: UITextStyle.normalBody.copyWith(height: 2),
                          ),
                        ),
                        spacerHeight(),
                        const CustomPinCodeFields(length: 5),
                        spacerHeight(),
                        AcceptButton(
                          onPressed: () {},
                          text: 'تأكيد',
                          backgroundColor: UIColors.primary,
                        ),
                        spacerHeight(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.repeat,
                                size: 22,
                                color: UIColors.white,
                              ),
                            ),
                            Text(
                              'إعادة إرسال الرمز',
                              style: UITextStyle.normalBody.copyWith(
                                color: UIColors.normalText,
                              ),
                            ),
                          ],
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
