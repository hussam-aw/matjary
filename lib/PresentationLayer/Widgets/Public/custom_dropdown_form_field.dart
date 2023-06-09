import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

// ignore: must_be_immutable
class CustomDropdownFormField extends StatelessWidget {
  CustomDropdownFormField({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
  });

  List<String> items;
  final String? value;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) items = [''];
    return DropdownButtonFormField(
      value: value == null || value == "" ? items[0] : value,
      isDense: true,
      isExpanded: true,
      decoration: textFieldStyle,
      style: UITextStyle.normalBody,
      focusColor: UIColors.normalText,
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
      onChanged: onChanged,
    );
  }
}
