import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                const PageTitle(title: 'الإعدادات'),
                spacerHeight(height: 22),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomBox(
                          title: 'الملف الشخصي',
                          subTitle: 'تعديل بيانات الملف الشخصي',
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                          onTap: () {
                            Get.toNamed(AppRoutes.profileScreen);
                          },
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'تعيين سعر التعادل',
                          subTitle: 'سعر صرف السوق لمقابل العملة الأجنبية',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'اسم المتجر',
                          subTitle:
                              'تعيين اسم المتجر لاستخدماه في التقارير ( طباعة الفواتير - كشوفات الحسابات )',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'شعار المتجر',
                          subTitle:
                              'تعديل شعار المتجر لاستخدماه في التقارير ( طباعة الفواتير - كشوفات الحسابات )',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'عنوان المتجر',
                          subTitle: 'يظهر في ذيل القواتير والكشوفات',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'أرقام التواصل',
                          subTitle: 'يظهر في ذيل القواتير والكشوفات',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'النسخ الاحتياطي',
                          subTitle: 'نسخ احتياطي للبيانات لحفظها محلياً ',
                          onTap: () {},
                        ),
                        spacerHeight(),
                        CustomBox(
                          title: 'تحديثات التطبيق',
                          subTitle: 'تتبع التحديثات الجديدة للتطبيق',
                          onTap: () {},
                        ),
                      ],
                    ),
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
