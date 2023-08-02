import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/store_settings_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/store_settings_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/main.dart';

class StoreIconScreen extends StatelessWidget {
  StoreIconScreen({super.key});

  final storeSettingsScreenController =
      Get.put(StoreSettingsScreenController());
  final storeSettingsController = Get.find<StoreSettingsController>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                spacerHeight(height: 70),
                const PageTitle(title: 'أيقونة المتجر'),
                spacerHeight(height: 22),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return CircleAvatar(
                            radius: 100,
                            backgroundImage: storeSettingsScreenController
                                    .selectedStoreIcon.value.isEmpty
                                ? NetworkImage(MyApp.storeSettings!.icon)
                                    as ImageProvider
                                : FileImage(File(storeSettingsScreenController
                                    .selectedStoreIcon.value)),
                          );
                        },
                      ),
                      Obx(() {
                        return storeSettingsScreenController
                                .selectedStoreIcon.value.isEmpty
                            ? AcceptIconButton(
                                center: true,
                                text: Text(
                                  'اختيار شعار جديد',
                                  style: UITextStyle.normalBody.copyWith(
                                    color: UIColors.menuTitle,
                                  ),
                                ),
                                icon: const Icon(
                                  FontAwesomeIcons.images,
                                  size: 20,
                                  color: UIColors.mainIcon,
                                ),
                                backgroundColor: UIColors.white,
                                onPressed: () async {
                                  storeSettingsScreenController
                                      .getSelectedStoreImage();
                                },
                              )
                            : AcceptButton(
                                text: 'تعيين الشعار',
                                onPressed: () async {
                                  storeSettingsController
                                      .setSelectedStoreIconPath(
                                          storeSettingsScreenController
                                              .selectedStoreIcon.value);
                                  await storeSettingsController
                                      .updateStoreSettings();
                                },
                                isLoading:
                                    storeSettingsController.isLoading.value,
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
