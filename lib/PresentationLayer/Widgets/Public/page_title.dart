import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.titleColor = UIColors.white,
  });

  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          softWrap: true,
          //overflow: TextOverflow.ellipsis,
          style: UITextStyle.boldHeading.copyWith(
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
