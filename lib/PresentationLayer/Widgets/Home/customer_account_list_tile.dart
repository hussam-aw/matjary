import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

// ignore: must_be_immutable
class CustomerAccountListTile extends StatelessWidget {
  CustomerAccountListTile({
    super.key,
    required this.customerName,
    required this.customerImage,
    required this.customerStatus,
    required this.customerBalance,
  });

  String customerName;
  String customerImage;
  String customerStatus;
  String customerBalance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(customerImage),
                    ),
                    spacerWidth(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            softWrap: true,
                            //overflow: TextOverflow.ellipsis,
                            style: UITextStyle.boldBody,
                          ),
                          spacerHeight(),
                          Text(
                            customerStatus,
                            softWrap: true,
                            //overflow: TextOverflow.ellipsis,
                            style: UITextStyle.normalSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              spacerWidth(),
              Text(
                customerBalance,
                style: UITextStyle.boldMeduim,
              ),
            ],
          ),
        ),
        spacerWidth(width: 20),
        const Icon(
          FontAwesomeIcons.arrowLeft,
          color: UIColors.normalIcon,
        )
      ],
    );
  }
}

// ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: CircleAvatar(
//         radius: 22,
//         backgroundImage: AssetImage(customerImage),
//       ),
//       title: Text(
//         customerName,
//         style: UITextStyle.boldBody,
//       ),
//       subtitle: Text(
//         customerStatus,
//         style: UITextStyle.normalSmall,
//       ),
//       trailing: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             customerBalance,
//             style: UITextStyle.boldMeduim,
//           ),
//           spacerWidth(width: 20),
//           const Icon(
//             FontAwesomeIcons.arrowLeft,
//             color: UIColors.normalIcon,
//           ),
//         ],
//       ),
//     );
