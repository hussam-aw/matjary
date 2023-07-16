import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_statement_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/account_statement_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class AccountStatementDatesBottomSheet extends StatelessWidget {
  AccountStatementDatesBottomSheet({super.key});

  final accounStatementScreenController =
      Get.find<AccountStatementScreenController>();
  final accounStatementController = Get.find<AccountStatementController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.width * .7,
        decoration: const BoxDecoration(
          borderRadius: raduis32top,
          color: UIColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SectionTitle(title: ':من'),
                    spacerHeight(height: 10),
                    CustomTextFormField(
                      readOnly: true,
                      controller: accounStatementController.fromDateController,
                      keyboardType: TextInputType.datetime,
                      style: UITextStyle.normalMeduim.copyWith(
                        color: UIColors.darkText,
                      ),
                      decoration: normalTextFieldStyle,
                      suffix: InkWell(
                        onTap: () async {
                          accounStatementScreenController.selectFromDate(
                              await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      accounStatementController
                                          .fromDateController.text),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)));
                        },
                        child: const Icon(
                          Icons.date_range,
                          color: UIColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spacerWidth(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const SectionTitle(title: ':الى'),
                    spacerHeight(height: 10),
                    CustomTextFormField(
                      readOnly: true,
                      controller: accounStatementController.toDateController,
                      keyboardType: TextInputType.datetime,
                      style: UITextStyle.normalMeduim.copyWith(
                        color: UIColors.darkText,
                      ),
                      decoration: normalTextFieldStyle,
                      suffix: InkWell(
                        onTap: () async {
                          accounStatementScreenController.selectToDate(
                              await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      accounStatementController
                                          .toDateController.text),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)));
                        },
                        child: const Icon(
                          Icons.date_range,
                          color: UIColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
