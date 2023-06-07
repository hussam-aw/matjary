import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class TableTitles extends StatelessWidget {
  const TableTitles({
    super.key,
    required this.firstColumnTitle,
    required this.secondColumnTitle,
    required this.thirdColumnTitle,
    required this.fourthColumnTitle,
    this.isDecorated = false,
    this.titleTextStyle = UITextStyle.boldBody,
  });

  final String firstColumnTitle;
  final String secondColumnTitle;
  final String thirdColumnTitle;
  final String fourthColumnTitle;
  final bool isDecorated;
  final TextStyle titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: isDecorated
          ? BoxDecoration(
              color: UIColors.containerBackground,
              border: Border.all(color: UIColors.white),
              borderRadius: raduis15,
            )
          : null,
      child: Row(
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
      ),
    );
  }
}
