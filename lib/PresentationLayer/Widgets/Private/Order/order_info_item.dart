import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({
    super.key,
    required this.itemTitle,
    required this.itemText,
  });

  final String itemTitle;
  final String itemText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            itemTitle,
            softWrap: true,
            //overflow: TextOverflow.ellipsis,
            style: UITextStyle.normalBody,
          ),
          spacerHeight(),
          Text(
            itemText,
            softWrap: true,
            //overflow: TextOverflow.ellipsis,
            style: UITextStyle.normalBody,
          ),
        ],
      ),
    );
  }
}
