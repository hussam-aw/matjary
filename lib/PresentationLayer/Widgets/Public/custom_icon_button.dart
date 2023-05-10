import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.heroTag = "",
  });

  final Icon icon;
  final Object? heroTag;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: UIColors.white,
        borderRadius: raduis15,
      ),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}
