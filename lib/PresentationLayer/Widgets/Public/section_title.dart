import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        title,
        style: UITextStyle.normalBody,
      ),
    );
  }
}
