import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

import '../../BussinessLayer/Controllers/ware_controller.dart';

class CreateEditWareScreen extends StatelessWidget {
  CreateEditWareScreen({super.key});
  final WareController wareController = Get.put(WareController());
  final Ware? ware = Get.arguments;
  @override
  Widget build(BuildContext context) {
    wareController.setWareDetails(ware);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const PageTitle(title: 'إنشاء | تعديل مستودع'),
                    ),
                    if (ware != null)
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                              title: 'هل تريد حذف المستودع؟',
                              buttonText: 'حذف',
                              confirmOnPressed: () async {
                                await wareController.deleteWare(ware!.id);
                                Get.until((route) =>
                                    route.settings.name ==
                                    AppRoutes.chooseWareScreen);
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: UIColors.primary,
                        ),
                      ),
                  ],
                ),
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
                          CustomTextFormField(
                            controller: wareController.nameOfWareController,
                            hintText: 'اسم المستودع',
                          ),
                          spacerHeight(),
                          /* CustomTextFormField(
                                  controller: TextEditingController(),
                                  hintText: 'الموظف المسؤول',
                                ),
                                spacerHeight(),
                                CustomTextFormField(
                                  controller: TextEditingController(),
                                  hintText: 'مكان المستودع',
                                ), */
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return AcceptButton(
                    text: ware != null ? "تعديل" : "إنشاء",
                    onPressed: () {
                      if (ware != null) {
                        wareController.updateWare(ware!.id);
                      } else {
                        wareController.addWare();
                      }
                    },
                    isLoading: wareController.loading.value,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
