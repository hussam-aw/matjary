import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: items[0],
      isDense: true,
      decoration: textFieldStyle,
      style: UITextStyle.normalBody,
      dropdownColor: UIColors.textFieldBackground,
      icon: const Icon(
        Icons.keyboard_arrow_down_sharp,
        color: UIColors.normalIcon,
        size: 25,
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value),
          ),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }
}
