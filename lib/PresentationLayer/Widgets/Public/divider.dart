import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';

class divider extends StatelessWidget {
  const divider({super.key, required this.thickness});

  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: UIColors.dividerLine,
    );
  }
}
