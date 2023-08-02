import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class TableDetailsItem extends StatelessWidget {
  const TableDetailsItem({
    super.key,
    required this.rowCells,
  });

  final Map<dynamic, int> rowCells;

  List<Widget> buildCells() {
    List<Widget> cells = [];
    rowCells.forEach((key, value) {
      if (key != null) {
        if (key is String) {
          cells.add(Expanded(
            flex: value,
            child: Center(
              child: Text(
                key,
                //overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalBody,
              ),
            ),
          ));
        } else if (key is Widget) {
          cells.add(Expanded(
            flex: value,
            child: Center(child: key),
          ));
        }
      }
    });

    return cells;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: UIColors.containerBorder),
        ),
      ),
      child: Row(children: buildCells()),
    );
  }
}
