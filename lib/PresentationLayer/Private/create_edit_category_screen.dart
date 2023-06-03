import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/category_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateEditCategoryScreen extends StatelessWidget {
  CreateEditCategoryScreen({super.key});

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            children: [
              const PageTitle(title: 'إنشاء | تعديل تصنيف بضاعة'),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: 'المعلومات الأساسية'),
                        spacerHeight(),
                        CustomTextFormField(
                          controller: categoryController.nameController,
                          hintText: 'اسم التصنيف',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              spacerHeight(height: 30),
              Obx(
                () {
                  return AcceptButton(
                    text: 'إنشاء',
                    onPressed: () {
                      categoryController.createCategory();
                    },
                    isLoading: categoryController.loading.value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
