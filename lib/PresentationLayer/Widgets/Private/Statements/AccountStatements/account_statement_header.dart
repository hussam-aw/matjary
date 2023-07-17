import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class AccountStatementHeader extends StatelessWidget {
  const AccountStatementHeader({
    super.key,
    required this.accountName,
    required this.accountType,
    required this.accountImage,
    this.textColor = UIColors.lightNormalText,
  });

  final String accountName;
  final String accountType;
  final String accountImage;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage(accountImage),
        ),
        spacerWidth(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountName,
                softWrap: true,
                style: UITextStyle.normalMeduim.copyWith(
                  color: textColor,
                ),
              ),
              spacerHeight(),
              Text(
                accountType,
                softWrap: true,
                style: UITextStyle.normalBody.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
