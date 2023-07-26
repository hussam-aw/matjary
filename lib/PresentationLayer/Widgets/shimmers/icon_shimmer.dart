import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/base_shimmer.dart';

class IconShimmer extends StatelessWidget {
  const IconShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmerwidget.circular(
        width: const Size.fromRadius(22).width,
        height: const Size.fromRadius(22).height);
  }
}
