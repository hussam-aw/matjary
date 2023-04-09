import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items
              .map(
                (choice) => Container(
                  width: 140,
                  height: 42,
                  decoration: BoxDecoration(
                    color: UIColors.white,
                    borderRadius: raduis15,
                  ),
                  child: Center(
                    child: Text(
                      choice,
                      style: UITextStyle.normalMeduim.copyWith(
                        color: UIColors.menuTitle,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
