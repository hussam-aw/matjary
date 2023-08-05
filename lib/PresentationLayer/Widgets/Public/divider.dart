// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';

class divider extends StatelessWidget {
  const divider(
      {super.key, required this.thickness, this.color = UIColors.dividerLine});

  final double thickness;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color,
    );
  }
}
