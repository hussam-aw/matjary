import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({
    super.key,
    required this.productName,
    required this.productQuantity,
    required this.productPrice,
    required this.productTotal,
  });

  final String productName;
  final int productQuantity;
  final num productPrice;
  final num productTotal;

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
                productName,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                productQuantity.toString(),
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                productPrice.toString(),
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                productTotal.toString(),
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
