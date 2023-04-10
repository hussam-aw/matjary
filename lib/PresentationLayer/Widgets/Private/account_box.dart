import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class AccountBox extends StatelessWidget {
  const AccountBox({super.key, required this.accountName});

  final String accountName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
      ),
      child: Text(
        accountName,
        style: UITextStyle.normalMeduim.copyWith(
          color: UIColors.lightNormalText,
        ),
      ),
    );
  }
}
