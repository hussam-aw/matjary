import 'package:flutter/material.dart';
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
    this.selectionColor = UIColors.containerBackground,
    this.unselectionColor = UIColors.containerBackground,
    this.selectedTextColor = UIColors.white,
    this.borderExist = false,
    required this.onTap,
  });

  final String text;
  final double width;
  final TextStyle style;
  final bool isSelected;
  final Color selectionColor;
  final Color unselectionColor;
  final Color selectedTextColor;
  final bool borderExist;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: isSelected ? selectionColor : unselectionColor,
          border: isSelected && borderExist
              ? Border.all(
                  color: UIColors.primary,
                  width: 2,
                )
              : null,
          borderRadius: raduis15,
        ),
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            text,
            softWrap: true,
            //overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              color: isSelected ? selectedTextColor : UIColors.normalText,
            ),
          ),
        ),
      ),
    );
  }
}
