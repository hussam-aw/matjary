import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/auth_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/main.dart';

import '../Home/drawer_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: UIColors.containerBackground,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: UIColors.primary),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: UIColors.containerBackground,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                accountName: Text(
                    MyApp.appUser != null ? MyApp.appUser!.name : "App User"),
                accountEmail:
                    Text(MyApp.appUser != null ? MyApp.appUser!.email : ""),
              ),
              if (MyApp.appUser != null)
                const DrawerListTile(
                  title: "الحساب الشخصي",
                  subtitle: "التعديل على بيانات الملف الشخصي",
                  iconData: Icons.people,
                  onTap: null,
                ),
              if (MyApp.appUser == null)
                const DrawerListTile(
                  title: "تسجيل الدخول",
                  subtitle: "تسجيل الدخول بالحساب الشخصي",
                  iconData: Icons.logout,
                  onTap: null,
                ),
              const DrawerListTile(
                title: "الرئيسية",
                subtitle: "الواجهة الرئيسية للتطبيق",
                iconData: Ionicons.home,
                onTap: null,
              ),
              DrawerListTile(
                title: "الحسابات",
                subtitle: "تصفح و تعديل الحسابات",
                iconData: FontAwesomeIcons.fileInvoice,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseAccountScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "البنوك",
                subtitle: "تصفح و تعديل البنوك",
                iconData: Ionicons.cart,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseBankAccountScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "المستودعات",
                subtitle: "تصفح و تعديل المستودعات",
                iconData: Icons.warehouse,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseWareScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "الفئات",
                subtitle: "تصفح و تعديل الفئات",
                iconData: Ionicons.menu,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseCategoryScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "البضاعة",
                subtitle: "تصفح و تعديل البضاعة",
                iconData: Ionicons.apps,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseProductScreen,
                  );
                },
              ),
              const DrawerListTile(
                title: "التسعير الشامل",
                subtitle: "تعديل كل الأسعار من نافذة واحدة",
                iconData: Ionicons.pricetag,
                onTap: null,
              ),
              const DrawerListTile(
                title: "التقارير",
                subtitle: "التقارير المحاسبية",
                iconData: Ionicons.analytics,
                onTap: null,
              ),
              const DrawerListTile(
                title: "الإعدادات",
                subtitle: "التعديل في إعدادات التطبيق",
                iconData: Icons.settings,
                onTap: null,
              ),
              if (MyApp.appUser != null)
                DrawerListTile(
                  title: "تسجيل الخروج",
                  subtitle: "إنهاء الجلسة وتسجيل الدخول",
                  iconData: Icons.logout,
                  onTap: () async {
                    await authController.logout();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
