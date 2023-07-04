import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CustomRadioGroup extends StatelessWidget {
  CustomRadioGroup({
    super.key,
    required this.items,
    this.height = 45,
    this.scrollDirection = Axis.horizontal,
  });

  final List<Widget> items;
  final double height;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return items.length <= 2
        ? Container(
            height: height,
            child: scrollDirection == Axis.horizontal
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: items[0]),
                        spacerWidth(width: 60),
                        Expanded(child: items[1]),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: items,
                    ),
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
