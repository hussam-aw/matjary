import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;
  // final Function() editOnPressed;
  // final String deleteDialogTitle;
  // final String deleteDialogButtonText;
  // final Function() deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //height: 67,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: const BoxDecoration(
          color: UIColors.containerBackground,
        ),
        child: Text(
          title,
          softWrap: true,
          //overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: UITextStyle.normalMeduim.copyWith(
            color: UIColors.lightNormalText,
          ),
        ),
      ),
    );
  }
}

// SizedBox(
//             width: 80,
//             //height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: editOnPressed,
//                   child: const Icon(
//                     FontAwesomeIcons.penToSquare,
//                     color: UIColors.white,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.dialog(
//                       CustomDialog(
//                         title: deleteDialogTitle,
//                         buttonText: deleteDialogButtonText,
//                         confirmOnPressed: deleteOnPressed,
//                       ),
//                     );
//                   },
//                   child: const Icon(
//                     Icons.delete,
//                     color: UIColors.white,
//                     size: 27,
//                   ),
//                 ),
//               ],
//             ),
//           ),