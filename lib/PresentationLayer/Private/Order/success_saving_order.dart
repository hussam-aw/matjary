import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SuccessSavingOrder extends StatelessWidget {
  const SuccessSavingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: UIColors.containerBackground,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 80,
                        color: UIColors.white,
                      ),
                    ),
                    spacerHeight(),
                    Text(
                      'تم الحفظ بنجاح',
                      style: UITextStyle.boldHeading,
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(height: 22),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AcceptButton(
                  text: 'إنشاء فاتورة جديدة',
                  onPressed: () {},
                ),
                spacerHeight(),
                AcceptButton(
                  text: 'العودة للرئيسية',
                  style: acceptButtonWithBorderStyle,
                  textStyle: UITextStyle.boldMeduim.copyWith(
                    color: UIColors.smallText,
                  ),
                  backgroundColor: UIColors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
