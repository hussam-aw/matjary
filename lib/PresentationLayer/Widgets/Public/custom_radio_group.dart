import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CustomRadioGroup extends StatelessWidget {
  const CustomRadioGroup({
    super.key,
    required this.items,
    this.height = 45,
    this.scrollDirection = Axis.vertical,
    this.displayInGrid = false,
    this.childAspectRatio = 4,
    this.crossAxisSpacing = 30.0,
  });

  final List<Widget> items;
  final double height;
  final Axis scrollDirection;
  final bool displayInGrid;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return items.length <= 2 || displayInGrid
        ? SizedBox(
            height: height,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: 30.0,
              childAspectRatio: childAspectRatio,
              scrollDirection: scrollDirection,
              shrinkWrap: true,
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
