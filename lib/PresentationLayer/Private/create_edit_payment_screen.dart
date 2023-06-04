import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
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

class CreateEditPaymentScreen extends StatelessWidget {
  CreateEditPaymentScreen({super.key});

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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إنشاء | تعديل دفعة'),
                spacerHeight(height: 22),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioGroup(
                          height: 100,
                          items: [
                            IconRadioItem(
                              icon: Ionicons.happy,
                              text: 'مقبوضات',
                              isSelected: true,
                              onTap: () {},
                            ),
                            IconRadioItem(
                              icon: Ionicons.sad,
                              text: 'مدفوعات',
                              isSelected: false,
                              onTap: () {},
                            )
                          ],
                        ),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'إختر الصندوق'),
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
                                var account = await Get.toNamed(
                                    AppRoutes.chooseAccountScreen,
                                    arguments: {
                                      'mode': 'selection',
                                      'style': 'bank',
                                      'accounts':
                                          accountsController.bankAccounts
                                    });
                                // orderScreenController.selectAccountBasedOnType(
                                //     account, 'bank');
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'الطرف المقابل'),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller: TextEditingController(),
                                hintText: 'الزبون',
                              ),
                            ),
                            spacerWidth(),
                            CustomIconButton(
                              icon: const Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: UIColors.mainIcon,
                              ),
                              onPressed: () async {
                                var account = await Get.toNamed(
                                    AppRoutes.chooseAccountScreen,
                                    arguments: {
                                      'mode': 'selection',
                                      'style': 'clientsAndSuppliers',
                                      'accounts': accountsController
                                          .clientAndSupplierAccounts
                                    });
                                // orderScreenController.selectAccountBasedOnType(
                                //     account, 'clientsAndSuppliers');
                              },
                            ),
                          ],
                        ),
                        spacerHeight(height: 30),
                        SectionTitle(title: 'تاريخ الدفعة'),
                        spacerHeight(),
                        TextFormField(
                          readOnly: true,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.datetime,
                          style: UITextStyle.normalBody,
                          decoration: textFieldStyle.copyWith(
                              suffixIcon: IconButton(
                            onPressed: () async {
                              // statementScreenController.selectDate(
                              //     await showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.parse(
                              //             statementController
                              //                 .dateController.text),
                              //         firstDate: DateTime(1900),
                              //         lastDate: DateTime(2100)));
                            },
                            icon: const Icon(
                              Icons.date_range,
                              color: UIColors.white,
                            ),
                          )),
                        ),
                        spacerHeight(height: 20),
                        SectionTitle(title: 'ملاحظات'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: TextEditingController(),
                          maxLines: 5,
                          hintText: 'شب التوصيل: حسام',
                        ),
                      ],
                    ),
                  ),
                ),
                spacerHeight(),
                AcceptButton(
                  text: 'حفظ',
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
