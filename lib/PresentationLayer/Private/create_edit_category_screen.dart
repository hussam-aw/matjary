import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/category_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/DataAccesslayer/Models/category.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/success_saving_options_menu.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

import '../Widgets/Public/spacerWidth.dart';

class CreateEditCategoryScreen extends StatelessWidget {
  CreateEditCategoryScreen({super.key});

  final categoryController = Get.put(CategoryController());
  final Category? category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    categoryController.setCategoryDetails(category);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: PageTitle(title: 'إنشاء | تعديل تصنيف بضاعة'),
                  ),
                  if (category != null)
                    InkWell(
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                            title: 'هل تريد حذف التصنيف؟',
                            acceptButton: Obx(
                              () => AcceptButton(
                                text: 'حذف',
                                onPressed: () async {
                                  await categoryController
                                      .deleteCategory(category!.id);
                                  Get.until((route) =>
                                      route.settings.name ==
                                      AppRoutes.chooseCategoryScreen);
                                },
                                isLoading: categoryController.loading.value,
                              ),
                            ),
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
                          controller: categoryController.nameController,
                          hintText: 'اسم التصنيف',
                        ),
                        spacerHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: true,
                                controller:
                                    categoryController.parentCategoryController,
                                hintText: 'التصنيف الأب (اختياري)',
                              ),
                            ),
                            spacerWidth(),
                            CustomIconButton(
                              icon: const Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: UIColors.mainIcon,
                              ),
                              onPressed: () async {
                                var category = await Get.toNamed(
                                  AppRoutes.chooseCategoryScreen,
                                  arguments: 'selection',
                                );
                                categoryController.setParentCategory(category);
                              },
                            ),
                          ],
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
                    text: category != null ? 'تعديل' : 'إنشاء',
                    onPressed: () async {
                      if (category != null) {
                        await categoryController.updateCategory(category!.id);
                      } else {
                        await categoryController.createCategory();
                        if (categoryController.savingState) {
                          Get.dialog(
                            const SuccessSavingOptionsMenu(
                              createButtonText: 'إنشاء تصنيف جديد',
                            ),
                          );
                        }
                      }
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
