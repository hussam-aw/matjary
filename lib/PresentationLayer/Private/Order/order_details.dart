import 'package:flutter/material.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/order_product_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'تفاصيل الفاتورة'),
            spacerHeight(),
            SizedBox(
              width: 120,
              child: AcceptButton(
                text: 'اختيار منتجات',
                onPressed: () {},
              ),
            ),
            spacerHeight(),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return OrderProductBox();
                },
                separatorBuilder: (context, index) => spacerHeight(),
                itemCount: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
