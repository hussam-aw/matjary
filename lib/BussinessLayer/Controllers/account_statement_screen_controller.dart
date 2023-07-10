import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class AccountStatementScreenController extends GetxController {
  String currentAccountStatementFilterType = 'عن كامل المدة';

  List<String> accountStatementFilterTypes = [
    'عن كامل المدة',
    'آخر أسبوع',
    'بين تاريخين',
    'آخر شهر',
  ];

  Map<String, String> accountStatementTypes = {
    'عن كامل المدة': 'all',
    'آخر أسبوع': 'last_week',
    'بين تاريخين': 'between_dates',
    'آخر شهر': 'last_month',
  };

  RxMap<String, bool> accountStatementFilterTypesSelection = {
    'عن كامل المدة': true,
    'آخر أسبوع': false,
    'بين تاريخين': false,
    'آخر شهر': false,
  }.obs;

  void resetAccountStatementFilterTypes() {
    accountStatementFilterTypesSelection.value = {
      'عن كامل المدة': false,
      'آخر أسبوع': false,
      'بين تاريخين': false,
      'آخر شهر': false,
    };
  }

  void setAccountStatementType(type) {
    resetAccountStatementFilterTypes();
    currentAccountStatementFilterType = type;
    accountStatementFilterTypesSelection[type] = true;
    if (type == 'بين تاريخين') {
      Get.bottomSheet(
        Container(
          height: Get.width * .6,
          decoration: const BoxDecoration(
            borderRadius: raduis32top,
            color: UIColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'من:',
                              style: UITextStyle.normalMeduim
                                  .copyWith(color: UIColors.darkText),
                            ),
                            spacerHeight(height: 10),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              decoration: normalTextFieldStyle,
                            ),
                          ],
                        ),
                      ),
                      spacerWidth(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'الى:',
                              style: UITextStyle.normalMeduim
                                  .copyWith(color: UIColors.darkText),
                            ),
                            spacerHeight(height: 10),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              decoration: normalTextFieldStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: AcceptButton(
                    text: 'تأكيد',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
