import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage(customerImage),
      ),
      title: Text(
        customerName,
        style: UITextStyle.boldBody,
      ),
      subtitle: Text(
        customerStatus,
        style: UITextStyle.normalSmall,
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              customerBalance,
              style: UITextStyle.boldMeduim,
            ),
            spacerWidth(width: 30),
            const Icon(
              FontAwesomeIcons.arrowLeft,
              color: UIColors.normalIcon,
            ),
          ],
        ),
      ),
    );
  }
}
