import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Create/create_menu_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 350,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: const BoxDecoration(
          color: UIColors.white,
          borderRadius: raduis42top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'إنشاء جديد',
                style: UITextStyle.boldBody.copyWith(
                  color: UIColors.normalText,
                ),
              ),
            ),
            spacerHeight(height: 15),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                padding: const EdgeInsets.symmetric(vertical: 30),
                children: [
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_sale_point_ic.png',
                    title: 'فاتورة بيع',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/DExpense.png',
                    title: 'دفعة نقدية',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_calc_icon.png',
                    title: 'قيد محاسبي',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_ORDERS_icon.png',
                    title: 'كشف حساب',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_bank_icon.png',
                    title: 'صندوق نقدي',
                  ),
                  CreateMenuItem(
                    onTap: () {
                      Get.toNamed(AppRoutes.chooseAccountScreen);
                    },
                    icon: 'assets/icons/D_user_icon.png',
                    title: 'جهة عمل',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_PROD_icon_hov.png',
                    title: 'بضاعة',
                  ),
                  CreateMenuItem(
                    onTap: () {},
                    icon: 'assets/icons/D_ware_icon.png',
                    title: 'مستودع',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}