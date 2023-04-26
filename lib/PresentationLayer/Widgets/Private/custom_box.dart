import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.title,
    required this.editOnPressed,
    required this.deleteDialogTitle,
    this.deleteDialogButtonText = 'حذف',
    required this.deleteOnPressed,
  });

  final String title;
  final Function() editOnPressed;
  final String deleteDialogTitle;
  final String deleteDialogButtonText;
  final Function() deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UITextStyle.normalMeduim.copyWith(
                color: UIColors.lightNormalText,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.edit,
                    color: UIColors.white,
                  ),
                  onPressed: editOnPressed,
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.delete,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      Get.dialog(
                        CustomDialog(
                          title: deleteDialogTitle,
                          buttonText: deleteDialogButtonText,
                          confirmOnPressed: deleteOnPressed,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
