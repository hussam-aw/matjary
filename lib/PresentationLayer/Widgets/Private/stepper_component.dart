import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class StepperComponent extends StatelessWidget {
  String title;
  int index;
  int currentIndex;
  Widget? icon;

  bool isLast;
  StepperComponent({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.index,
    this.icon,
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
                  stepCircle(
                    backgroundColor: index == currentIndex
                        ? UIColors.containerBackground
                        : index > currentIndex
                            ? UIColors.containerBackground
                            : UIColors.primary,
                    borderColor: currentIndex == index
                        ? UIColors.white
                        : currentIndex > index
                            ? UIColors.primary
                            : UIColors.containerBackground,
                    icon: icon,
                  ),
                ],
              ),
              spacerHeight(),
              stepTitle(title),
            ],
          )
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    stepCircle(
                        backgroundColor: index == currentIndex
                            ? UIColors.containerBackground
                            : index > currentIndex
                                ? UIColors.containerBackground
                                : UIColors.primary,
                        borderColor: currentIndex == index
                            ? UIColors.white
                            : currentIndex > index
                                ? UIColors.primary
                                : UIColors.containerBackground),
                    Expanded(
                      child: stepLine(),
                    ),
                  ],
                ),
                spacerHeight(),
                stepTitle(title),
              ],
            ),
          );
  }
}

Widget stepCircle(
    {required backgroundColor, required borderColor, Widget? icon}) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: backgroundColor,
      border: Border.all(width: 2, color: borderColor),
    ),
    child: Center(
      child: icon,
    ),
  );
}

Widget stepLine() {
  return Container(
    height: 2,
    color: UIColors.stepperLine,
  );
}

Widget stepTitle(title) {
  return SizedBox(
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
  );
}
