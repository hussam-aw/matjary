import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.title,
    this.subTitle,
    this.leading,
    required this.onTap,
  });

  final String title;
  final String? subTitle;
  final Widget? leading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: const BoxDecoration(
          color: UIColors.containerBackground,
          borderRadius: raduis15,
        ),
        child: Row(
          children: [
            if (leading != null)
              Row(
                children: [
                  leading!,
                  spacerWidth(),
                ],
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalMeduim.copyWith(
                      color: UIColors.lightNormalText,
                    ),
                  ),
                  spacerHeight(),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      softWrap: true,
                      //overflow: TextOverflow.ellipsis,
                      style: UITextStyle.normalBody.copyWith(
                        color: UIColors.lightNormalText,
                        height: 1.3,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
