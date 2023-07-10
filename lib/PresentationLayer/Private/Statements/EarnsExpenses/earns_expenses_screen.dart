import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class EarnsExpensesScreen extends StatelessWidget {
  const EarnsExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'الإيرادات والمصاريف'),
                spacerHeight(height: 22),
                CustomRadioGroup(
                  scrollDirection: Axis.horizontal,
                  items: [
                    RadioButtonItem(
                      text: 'الكل',
                      selectionColor: UIColors.primary,
                      selectedTextColor: UIColors.white,
                      isSelected: true,
                      onTap: () async {},
                    ),
                    RadioButtonItem(
                      text: 'الإيرادات',
                      selectionColor: UIColors.primary,
                      selectedTextColor: UIColors.white,
                      isSelected: false,
                      onTap: () async {},
                    ),
                    RadioButtonItem(
                      text: 'المصاريف',
                      selectionColor: UIColors.primary,
                      selectedTextColor: UIColors.white,
                      isSelected: false,
                      onTap: () async {},
                    ),
                  ],
                ),
                spacerHeight(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
