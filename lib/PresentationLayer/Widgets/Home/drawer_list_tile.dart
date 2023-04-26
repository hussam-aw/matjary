import 'package:flutter/material.dart';

import '../../../Constants/ui_colors.dart';
import '../../../Constants/ui_text_styles.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.iconData,
      required this.onTap});
  final String title;
  final String subtitle;
  final IconData iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: UITextStyle.boldBody.apply(color: UIColors.white),
      ),
      subtitle: Text(
        subtitle,
        style: UITextStyle.normalSmall.apply(color: UIColors.lightNormalText),
      ),
      leading: Icon(
        iconData,
        color: UIColors.white,
        size: 30,
      ),
      onTap: onTap,
    );
  }
}
