import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class OrderDetailsInfoTitles extends StatelessWidget {
  const OrderDetailsInfoTitles({
    super.key,
    required this.firstColumnTitle,
    required this.secondColumnTitle,
    required this.thirdColumnTitle,
    required this.fourthColumnTitle,
    this.titleTextStyle = UITextStyle.boldBody,
  });

  final String firstColumnTitle;
  final String secondColumnTitle;
  final String thirdColumnTitle;
  final String fourthColumnTitle;
  final TextStyle titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Text(
              firstColumnTitle,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              secondColumnTitle,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              thirdColumnTitle,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              fourthColumnTitle,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
