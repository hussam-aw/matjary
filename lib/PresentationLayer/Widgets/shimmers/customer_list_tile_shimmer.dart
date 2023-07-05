import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/base_shimmer.dart';

class CustomerListTileShimmer extends StatelessWidget {
  const CustomerListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Shimmerwidget.circular(
                      width: const Size.fromRadius(22).width,
                      height: const Size.fromRadius(22).height),
                  spacerWidth(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Shimmerwidget.roundedrectangler(
                          width: 80, height: 15),
                      spacerHeight(),
                      const Shimmerwidget.roundedrectangler(
                          width: 40, height: 12)
                    ],
                  ),
                ],
              ),
              const Shimmerwidget.roundedrectangler(width: 80, height: 25)
            ],
          ),
        ),
        spacerWidth(width: 20),
        const Icon(
          FontAwesomeIcons.arrowLeft,
          color: UIColors.normalIcon,
        )
      ],
    );
  }
}
