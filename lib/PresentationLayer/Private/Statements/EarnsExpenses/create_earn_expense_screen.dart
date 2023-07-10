import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/icon_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateEarnExpenseScreen extends StatelessWidget {
  CreateEarnExpenseScreen({super.key});

  final accountsController = Get.find<AccountsController>();

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
                const PageTitle(title: 'إيراد | مصروف'),
                spacerHeight(height: 22),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioGroup(
                          height: 100,
                          childAspectRatio: 1.8,
                          items: [
                            IconRadioItem(
                              icon: FontAwesomeIcons.solidCircleDown,
                              text: 'إيرادات',
                              isSelected: true,
                              onTap: () {},
                            ),
                            IconRadioItem(
                              icon: FontAwesomeIcons.solidCircleUp,
                              text: 'مصاريف',
                              isSelected: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                        spacerHeight(height: 32),
                        const SectionTitle(title: 'إختر الصندوق'),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller: TextEditingController(),
                                hintText: 'الصندوق',
                              ),
                            ),
                            spacerWidth(),
                            CustomIconButton(
                              icon: const Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: UIColors.mainIcon,
                              ),
                              onPressed: () async {
                                // var account = await Get.toNamed(
                                //     AppRoutes.chooseAccountScreen,
                                //     arguments: {
                                //       'mode': 'selection',
                                //       'style': 'bank',
                                //       'accounts': accountsController.bankAccounts
                                //     });
                                //paymentController.setBankAccount(account);
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'تاريخ القيد'),
                        spacerHeight(),
                        CustomTextFormField(
                          readOnly: true,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.datetime,
                          style: UITextStyle.normalBody,
                          suffix: InkWell(
                            onTap: () async {
                              // paymentScreenController.selectDate(
                              //     await showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.parse(
                              //             paymentController
                              //                 .dateController.text),
                              //         firstDate: DateTime(1900),
                              //         lastDate: DateTime(2100)));
                            },
                            child: const Icon(
                              Icons.date_range,
                              color: UIColors.white,
                            ),
                          ),
                        ),
                        spacerHeight(height: 22),
                        const SectionTitle(title: 'ملاحظات'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: TextEditingController(),
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          hintText: 'نثريات - شراء شاي',
                        ),
                      ],
                    ),
                  ),
                ),
                AcceptButton(
                  text: 'حفظ',
                  onPressed: () {},
                ),
                spacerHeight(),
                AcceptButton(
                  text: 'حذف',
                  backgroundColor: UIColors.deleteButton,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
