import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: UITextStyle.boldHeading,
        ),
      ),
    );
  }
}
