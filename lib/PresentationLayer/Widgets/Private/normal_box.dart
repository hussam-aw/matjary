import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class NormalBox extends StatelessWidget {
  const NormalBox({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: const BoxDecoration(
          color: UIColors.containerBackground,
        ),
        child: Text(
          title,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: UITextStyle.normalMeduim.copyWith(
            color: UIColors.lightNormalText,
          ),
        ),
      ),
    );
  }
}
