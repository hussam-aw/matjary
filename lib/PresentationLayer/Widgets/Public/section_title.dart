import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.textStyle = UITextStyle.normalBody,
    this.titleColor = UIColors.normalText,
  });

  final String title;
  final TextStyle textStyle;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        softWrap: true,
        style: textStyle.copyWith(
          color: titleColor,
        ),
      ),
    );
  }
}
