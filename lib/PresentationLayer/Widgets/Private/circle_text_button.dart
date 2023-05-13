import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CircleTextButton extends StatelessWidget {
  const CircleTextButton({
    super.key,
    required this.text,
    this.textStyle = UITextStyle.boldHeading,
    required this.onTap,
  });

  final String text;
  final TextStyle textStyle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
