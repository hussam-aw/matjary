import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/base_shimmer.dart';

class OrderCountShimmer extends StatelessWidget {
  const OrderCountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmerwidget.roundedrectangler(width: 60, height: 25);
  }
}
