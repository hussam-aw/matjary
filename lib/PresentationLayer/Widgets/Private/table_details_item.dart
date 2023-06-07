import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class TableDetailsItem extends StatelessWidget {
  const TableDetailsItem({
    super.key,
    required this.firstColumnItem,
    required this.secondColumnItem,
    required this.thirdColumnItem,
    required this.fourthColumnItem,
  });

  final String firstColumnItem;
  final String secondColumnItem;
  final String thirdColumnItem;
  final String fourthColumnItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: UIColors.containerBorder),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                firstColumnItem,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                secondColumnItem,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                thirdColumnItem,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                fourthColumnItem,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
