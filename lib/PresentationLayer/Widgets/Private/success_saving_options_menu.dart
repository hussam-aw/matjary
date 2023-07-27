import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SuccessSavingOptionsMenu extends StatelessWidget {
  const SuccessSavingOptionsMenu({
    super.key,
    required this.createButtonText,
  });

  final String createButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: UIColors.success,
                ),
                child: const Icon(
                  Icons.check,
                  size: 30,
                  color: UIColors.white,
                ),
              ),
              spacerHeight(),
              Text(
                'تم الحفظ بنجاح',
                style: UITextStyle.boldHeading.copyWith(
                  color: UIColors.darkText,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        AcceptButton(
          onPressed: () {
            Get.back();
          },
          text: createButtonText,
        ),
        spacerHeight(),
        AcceptButton(
          text: 'العودة للرئيسية',
          style: acceptButtonWithBorderStyle,
          textStyle: UITextStyle.boldMeduim,
          backgroundColor: UIColors.primary,
          onPressed: () {
            Get.until((route) => route.settings.name == AppRoutes.homeScreen);
          },
        ),
      ],
    );
  }
}
