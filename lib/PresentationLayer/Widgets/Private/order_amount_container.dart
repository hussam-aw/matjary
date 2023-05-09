import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderAmountContainer extends StatelessWidget {
  OrderAmountContainer({
    super.key,
    required this.title,
    required this.amount,
  });

  String title;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: UIColors.containerBackground,
          borderRadius: radius19,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
            spacerHeight(),
            Text(
              amount,
              style: UITextStyle.boldHeading.apply(),
            ),
          ],
        ),
      ),
    );
  }
}
