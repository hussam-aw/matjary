import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class TableDetailsItem extends StatelessWidget {
  const TableDetailsItem({
    super.key,
    this.firstColumnItem,
    this.secondColumnItem,
    this.thirdColumnItem,
    this.fourthColumnItem,
  });

  final String? firstColumnItem;
  final String? secondColumnItem;
  final String? thirdColumnItem;
  final dynamic fourthColumnItem;

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
            flex: secondColumnItem != null ? 1 : 2,
            child: Center(
              child: Text(
                firstColumnItem!,
                //overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          if (secondColumnItem != null)
            Expanded(
              flex: thirdColumnItem != null ? 1 : 2,
              child: Center(
                child: Text(
                  secondColumnItem!,
                  //overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalBody,
                ),
              ),
            ),
          if (thirdColumnItem != null)
            Expanded(
              child: Center(
                child: Text(
                  thirdColumnItem!,
                  //overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalBody,
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: (fourthColumnItem is String)
                  ? Text(
                      fourthColumnItem,
                      //overflow: TextOverflow.ellipsis,
                      style: UITextStyle.normalBody,
                    )
                  : fourthColumnItem,
            ),
          ),
        ],
      ),
    );
  }
}
