import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class IconRadioItem extends StatelessWidget {
  IconRadioItem({
    super.key,
    required this.icon,
    required this.text,
    this.width = 160,
    this.isSelected = false,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final double width;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: UIColors.containerBackground,
          border: isSelected
              ? Border.all(
                  color: UIColors.primary,
                  width: 2,
                )
              : null,
          borderRadius: raduis15,
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                icon,
                size: 40,
                color: UIColors.white,
              ),
            ),
            spacerHeight(),
            Expanded(
              child: Text(
                text,
                softWrap: true,
                //overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalMeduim,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
