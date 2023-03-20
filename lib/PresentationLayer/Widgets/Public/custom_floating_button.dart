import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 0.0,
      backgroundColor: UIColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: raduis15,
      ),
      child: const Icon(
        size: 45,
        FontAwesomeIcons.plus,
        color: UIColors.primary,
      ),
    );
  }
}
