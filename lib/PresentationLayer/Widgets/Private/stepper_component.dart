import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class StepperComponent extends StatelessWidget {
  String title;
  int index;
  int currentIndex;
  Widget? icon;
  VoidCallback onTap;

  bool isLast;
  StepperComponent({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.index,
    this.icon,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLast
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: index == currentIndex
                            ? UIColors.containerBackground
                            : index > currentIndex
                                ? UIColors.containerBackground
                                : UIColors.primary,
                        border: Border.all(
                            width: 2,
                            color: currentIndex == index
                                ? UIColors.white
                                : currentIndex > index
                                    ? UIColors.primary
                                    : UIColors.containerBackground),
                      ),
                      child: Center(
                        child: icon,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: UIColors.stepperLine,
                  ),
                ],
              ),
              spacerHeight(),
              SizedBox(
                width: 50,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalSmall.copyWith(
                    height: 1.2,
                    color: UIColors.normalText,
                  ),
                ),
              ),
            ],
          )
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: index == currentIndex
                              ? UIColors.containerBackground
                              : index > currentIndex
                                  ? UIColors.containerBackground
                                  : UIColors.primary,
                          border: Border.all(
                              width: 2,
                              color: currentIndex == index
                                  ? UIColors.white
                                  : currentIndex > index
                                      ? UIColors.primary
                                      : UIColors.containerBackground),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 2,
                      color: UIColors.stepperLine,
                    )),
                  ],
                ),
                spacerHeight(),
                SizedBox(
                  width: 50,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalSmall.copyWith(
                      height: 1.2,
                      color: UIColors.normalText,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
