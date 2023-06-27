import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class AmountBox extends StatelessWidget {
  AmountBox({super.key, required this.amount});

  String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 20,
        decoration: const BoxDecoration(
          color: UIColors.white,
          borderRadius: raduis15,
        ),
        child: Center(
          child: Text(
            amount,
            softWrap: true,
            style: UITextStyle.normalSmall.copyWith(color: UIColors.smallText),
          ),
        ),
      ),
    );
  }
}
