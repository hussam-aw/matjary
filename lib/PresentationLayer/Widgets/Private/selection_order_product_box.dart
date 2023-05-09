import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/circle_text_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class SelectionOrderProductBox extends StatelessWidget {
  const SelectionOrderProductBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: UIColors.containerBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'باوربانك ريماكس RM-79',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: UITextStyle.normalBody,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleTextButton(
                  text: '+',
                  onTap: () {},
                ),
                spacerWidth(width: 5),
                CircleTextButton(
                  text: '-',
                  onTap: () {},
                ),
                spacerWidth(width: 5),
                CircleTextButton(
                  text: '123',
                  textStyle: UITextStyle.normalSmall,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '200',
                style: UITextStyle.boldLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
