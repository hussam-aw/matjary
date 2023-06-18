import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/base_shimmer.dart';

class AmountShimmer extends StatelessWidget {
  const AmountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmerwidget.roundedrectangler(width: 80, height: 25);
  }
}
