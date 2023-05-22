import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 67,
              decoration: const BoxDecoration(
                color: UIColors.primary,
                borderRadius: raduis10,
              ),
              child: const Center(
                child: Text(
                  '#20',
                  style: UITextStyle.boldHeadingRedHat,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الزبون علي',
                    style: UITextStyle.boldBody,
                  ),
                  spacerHeight(height: 12),
                  const Text(
                    'إجمالي الفاتورة :   500000',
                    style: UITextStyle.normalSmall,
                  ),
                  spacerHeight(height: 8),
                  Text(
                    '20/05/2023',
                    style: UITextStyle.normalSmall.copyWith(
                      color: UIColors.titleNoteText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: const BoxDecoration(
                  borderRadius: raduis15,
                  color: UIColors.iconButtonGroupBackground),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.eye,
                      color: UIColors.primary,
                      size: 17,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.penToSquare,
                      color: UIColors.primary,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
