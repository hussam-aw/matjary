import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({super.key, required this.items});

  final List<RadioButtonItem> items;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }
}
