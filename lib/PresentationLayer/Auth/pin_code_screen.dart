import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/app_icon_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_pincode_fields.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key});

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
                  child: Column(
                    children: [
                      SizedBox(
                        width: 210,
                        child: Text(
                          ' لقد قمنا بارسال رمز مكون من 5 أرقام قم بادخاله لتأكيد الحساب',
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
                        text: 'تأكيد',
                        onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
