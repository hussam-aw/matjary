import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.backgroundColor = UIColors.white,
    this.borderRadius = raduis15,
    required this.onPressed,
  });

  final Icon icon;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}
