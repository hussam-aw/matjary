import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dropdown_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateStatementScreen extends StatelessWidget {
  CreateStatementScreen({super.key});

  final homeController = Get.find<HomeController>();
  final StatementController statementController =
      Get.put(StatementController());

  Widget productSelectionDialog(String type) {
    return AlertDialog(
      backgroundColor: UIColors.mainBackground,
      content: SizedBox(
        height: 500,
        width: Get.width,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return NormalBox(
              title: homeController.accounts[index].name,
              onTap: () {
                type == "from"
                    ? statementController.setFromAccountInDropdownButton(
                        homeController.accounts[index].name,
                      )
                    : statementController.setToAccountInDropdownButton(
                        homeController.accounts[index].name,
                      );
                Get.back();
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          itemCount: homeController.accounts.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var accountsList =
        homeController.accounts.map((account) => account.name).toList();
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
                const PageTitle(title: 'إنشاء | تعديل قيد محاسبي'),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'من الحساب'),
                          spacerHeight(),
                          GetBuilder(
                              init: statementController,
                              builder: (context) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropdownFormField(
                                        value: statementController.fromAccount,
                                        items: accountsList,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    spacerWidth(),
                                    CustomIconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: UIColors.mainIcon,
                                      ),
                                      onPressed: () {
                                        Get.dialog(
                                          productSelectionDialog("from"),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'إلى الحساب'),
                          spacerHeight(),
                          GetBuilder(
                              init: statementController,
                              builder: (context) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropdownFormField(
                                        value: statementController.toAccount,
                                        items: accountsList,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    spacerWidth(),
                                    CustomIconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: UIColors.mainIcon,
                                      ),
                                      onPressed: () {
                                        Get.dialog(
                                          productSelectionDialog("to"),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'مبلغ القيد'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller:
                                statementController.statementAmountController,
                            keyboardType: TextInputType.number,
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'تاريخ القيد'),
                          spacerHeight(),
                          TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            decoration: textFieldStyle.copyWith(
                              suffixIcon: const Icon(
                                Icons.date_range,
                                color: UIColors.white,
                              ),
                            ),
                          ),
                          spacerHeight(height: 20),
                          const SectionTitle(title: 'البيان'),
                          spacerHeight(),
                          CustomTextFormField(
                            controller: TextEditingController(),
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            hintText: 'تسجيل دفعة نقدية من الزبون علي',
                          ),
                          spacerHeight(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'نتيجة القيد: ',
                                  style: UITextStyle.normalBody
                                      .copyWith(height: 1.5),
                                ),
                                TextSpan(
                                  text:
                                      ' سيتم إضافة مبلغ 00000 إلى حساب الصندوق  وخصم مبلغ 00000 من حساب علي.',
                                  style: UITextStyle.normalBody.copyWith(
                                    height: 1.5,
                                    color: UIColors.normalText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                spacerHeight(height: 30),
                AcceptButton(
                  text: 'إنشاء',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
