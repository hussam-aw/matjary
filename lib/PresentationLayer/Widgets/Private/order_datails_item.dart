import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({
    super.key,
    required this.itemTitle,
    required this.itemText,
  });

  final String itemTitle;
  final String itemText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          itemTitle,
          overflow: TextOverflow.ellipsis,
          style: UITextStyle.normalBody,
        ),
        spacerHeight(),
        Text(
          itemText,
          overflow: TextOverflow.ellipsis,
          style: UITextStyle.normalBody,
        ),
      ],
    );
  }
}
