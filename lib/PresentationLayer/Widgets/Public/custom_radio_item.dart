import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class RadioButtonItem extends StatelessWidget {
  const RadioButtonItem({
    super.key,
    required this.text,
    this.isSelected = false,
    this.selectionColor = UIColors.white,
    this.selectedTextColor = UIColors.menuTitle,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final Color selectionColor;
  final Color selectedTextColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? selectionColor : UIColors.containerBackground,
          borderRadius: raduis15,
        ),
        child: Center(
          child: Text(
            text,
            style: UITextStyle.normalMeduim.copyWith(
              color: isSelected ? selectedTextColor : UIColors.normalText,
            ),
          ),
        ),
      ),
    );
  }
}
