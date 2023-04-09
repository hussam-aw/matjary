import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: UITextStyle.boldHeading,
      ),
    );
  }
}
