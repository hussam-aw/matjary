// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/earns_expenses_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/statement_with_type_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class EarnsExpensesScreen extends StatelessWidget {
  EarnsExpensesScreen({super.key});

  final earnsExpensesController = Get.find<EarnsExpensesController>();

  Widget buildStatementList(List<StatementWithType> statements) {
    return statements.isEmpty
        ? Center(
            child: Text(
              'لا يوجد دفعات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return StatementWithTypeBox(
                statement: statements[index],
              );
            },
            separatorBuilder: (context, index) => spacerHeight(),
            itemCount: statements.length,
          );
  }

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
                Obx(() {
                  return CustomRadioGroup(
                    scrollDirection: Axis.horizontal,
                    items: earnsExpensesController.filterTypes
                        .map(
                          (filterType) => RadioButtonItem(
                            text: filterType,
                            selectionColor: UIColors.primary,
                            selectedTextColor: UIColors.white,
                            isSelected: earnsExpensesController
                                .statementFilterTypesSelection
                                .value[filterType]!,
                            onTap: () async {
                              earnsExpensesController
                                  .setStatementFilterType(filterType);
                              await earnsExpensesController
                                  .getStatementsByType(filterType);
                            },
                          ),
                        )
                        .toList(),
                  );
                }),
                spacerHeight(height: 22),
                Expanded(
                  child: Obx(() {
                    return earnsExpensesController.isLoading.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : RefreshIndicator(
                            onRefresh: () async => await earnsExpensesController
                                .getStatementsByType(earnsExpensesController
                                    .currentStatementFilterType),
                            child: buildStatementList(
                                earnsExpensesController.currentStatements),
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AddButton(
          backgroundColor: UIColors.primary,
          iconColor: UIColors.white,
          onPressed: () {
            Get.toNamed(AppRoutes.createEarnExpenseScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
