import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class RadioButtonItem extends StatelessWidget {
  const RadioButtonItem({
    super.key,
    required this.text,
    this.width = 120,
    this.style = UITextStyle.normalMeduim,
    this.isSelected = false,
    this.selectionColor = UIColors.white,
    this.unselectionColor = UIColors.containerBackground,
    this.selectedTextColor = UIColors.menuTitle,
    required this.onTap,
  });

  final String text;
  final double width;
  final TextStyle style;
  final bool isSelected;
  final Color selectionColor;
  final Color unselectionColor;
  final Color selectedTextColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: isSelected ? selectionColor : unselectionColor,
          borderRadius: raduis15,
        ),
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            text,
            style: style.copyWith(
              color: isSelected ? selectedTextColor : UIColors.normalText,
            ),
          ),
        ),
      ),
    );
  }
}
