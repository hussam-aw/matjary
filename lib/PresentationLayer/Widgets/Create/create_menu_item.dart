import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateMenuItem extends StatelessWidget {
  const CreateMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.textColor = UIColors.menuTitle});

  final String title;
  final String icon;
  final Function() onTap;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: UIColors.containerBackground,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 50,
            height: 50,
          ),
          spacerHeight(),
          Expanded(
            child: Text(
              title,
              style: UITextStyle.boldSmall.copyWith(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
