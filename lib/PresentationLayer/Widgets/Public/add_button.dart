import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.backgroundColor = UIColors.white,
    this.iconColor = UIColors.primary,
    this.onPressed,
  });

  final Color backgroundColor;
  final Color iconColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: raduis15,
      ),
      onPressed: onPressed,
      child: Icon(
        size: 45,
        FontAwesomeIcons.plus,
        color: iconColor,
      ),
    );
  }
}
