import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderProductBox extends StatelessWidget {
  const OrderProductBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'باوربانك ريماكس RM-79',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalBody,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'الكمية:',
                        style: UITextStyle.small,
                      ),
                      spacerWidth(width: 7),
                      Container(
                        width: 32,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: UIColors.white,
                          borderRadius: raduis15,
                        ),
                        child: Center(
                          child: Text(
                            '5',
                            style: UITextStyle.smallBold
                                .copyWith(color: UIColors.smallText),
                          ),
                        ),
                      ),
                      spacerWidth(),
                      const Text(
                        'الافرادي:',
                        style: UITextStyle.small,
                      ),
                      spacerWidth(width: 7),
                      Container(
                        width: 32,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: UIColors.white,
                          borderRadius: raduis15,
                        ),
                        child: Center(
                          child: Text(
                            '5000',
                            style: UITextStyle.smallBold
                                .copyWith(color: UIColors.smallText),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '25000',
                style: UITextStyle.normalMeduim,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: UIColors.white,
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                    color: UIColors.white,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
