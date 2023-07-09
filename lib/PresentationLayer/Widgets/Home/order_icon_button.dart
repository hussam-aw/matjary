import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class OrderIconButton extends StatelessWidget {
  OrderIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  String title;
  IconData icon;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: 28,
            color: UIColors.white,
          ),
        ),
        spacerHeight(height: 8),
        Text(
          title,
          style: UITextStyle.normalSmall,
        )
      ],
    );
  }
}
