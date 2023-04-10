import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateEditBankScreen extends StatelessWidget {
  const CreateEditBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إنشاء | تعديل صندوق'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'المعلومات الأساسية'),
                          spacerHeight(),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'اسم الصندوق',
                            ),
                          ),
                          spacerHeight(),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'الموظف المسؤول',
                            ),
                          ),
                          spacerHeight(),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: textFieldStyle.copyWith(
                              hintText: 'المبلغ الإبتدائي ( الجرد الأولي )',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
