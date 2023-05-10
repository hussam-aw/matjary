import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CustomRadioGroup extends StatelessWidget {
  CustomRadioGroup({
    super.key,
    required this.items,
    this.scrollDirection = Axis.horizontal,
  });

  final List<RadioButtonItem> items;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return items.length <= 2
        ? Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: scrollDirection == Axis.horizontal
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items,
                  ),
          )
        : SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: scrollDirection,
              itemBuilder: (context, index) {
                return items[index];
              },
              separatorBuilder: (context, index) => spacerWidth(),
              itemCount: items.length,
            ),
          );
  }
}
