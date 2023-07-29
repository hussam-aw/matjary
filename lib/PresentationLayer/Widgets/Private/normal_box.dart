import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class NormalBox extends StatelessWidget {
  const NormalBox({
    super.key,
    required this.title,
    this.onTap,
    this.image = "",
    this.onLongTap,
  });

  final String title;
  final Function()? onTap;
  final Function()? onLongTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongTap,
      
      child: Container(
        //height: 55,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: const BoxDecoration(
          color: UIColors.containerBackground,
        ),
        child: Row(
          children: [
            if (image != "")
              Image.asset(
                image,
                width: 50,
                height: 50,
              ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                softWrap: true,
                //overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalMeduim.copyWith(
                  color: UIColors.lightNormalText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
