import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class TableTitles extends StatelessWidget {
  const TableTitles({
    super.key,
    required this.titles,
    this.isDecorated = false,
    this.titleTextStyle = UITextStyle.boldBody,
  });

  final List<String> titles;
  final bool isDecorated;
  final TextStyle titleTextStyle;

  List<Widget> buildColumns(List<String> list) {
    List<Widget> columns = [];
    for (var element in list) {
      columns.add(
        Expanded(
          child: Center(
            child: Text(
              element,
              //overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
          ),
        ),
      );
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: isDecorated
          ? BoxDecoration(
              color: UIColors.containerBackground,
              border: Border.all(color: UIColors.white),
              borderRadius: raduis15,
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buildColumns(titles)
      ),
    );
  }
}
