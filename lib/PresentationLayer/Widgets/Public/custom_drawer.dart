import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/auth_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/profile_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/store_settings_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/icon_shimmer.dart';
import 'package:matjary/main.dart';

import '../Home/drawer_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final authController = Get.put(AuthController());
  final accountsController = Get.find<AccountsController>();
  final profileController = Get.find<ProfileController>();
  final storeSettingsController = Get.find<StoreSettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: UIColors.containerBackground,
          child: ListView(
            children: [
              GetBuilder(
                  init: profileController,
                  builder: (context) {
                    return UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: UIColors.primary),
                      currentAccountPicture: Obx(() {
                        return storeSettingsController.isLoading.value
                            ? const IconShimmer()
                            : MyApp.storeSettings == null
                                ? const IconShimmer()
                                : CircleAvatar(
                                    backgroundColor:
                                        UIColors.containerBackground,
                                    backgroundImage:
                                        NetworkImage(MyApp.storeSettings!.icon),
                                  );
                      }),
                      accountName: Text(
                        MyApp.appUser != null
                            ? MyApp.appUser!.name
                            : "App User",
                        style: UITextStyle.boldMeduim,
                      ),
                      accountEmail: Text(
                          MyApp.appUser != null ? MyApp.appUser!.email : ""),
                    );
                  }),
              if (MyApp.appUser != null)
                DrawerListTile(
                  title: "الحساب الشخصي",
                  subtitle: "التعديل على بيانات الملف الشخصي",
                  iconData: Icons.people,
                  onTap: () {
                    Get.toNamed(AppRoutes.profileScreen);
                  },
                ),
              if (MyApp.appUser == null)
                const DrawerListTile(
                  title: "تسجيل الدخول",
                  subtitle: "تسجيل الدخول بالحساب الشخصي",
                  iconData: Icons.logout,
                  onTap: null,
                ),
              DrawerListTile(
                title: "الرئيسية",
                subtitle: "الواجهة الرئيسية للتطبيق",
                iconData: Ionicons.home,
                onTap: () => Get.toNamed(AppRoutes.homeScreen),
              ),
              DrawerListTile(
                title: "الحسابات",
                subtitle: "تصفح و تعديل الحسابات",
                iconData: FontAwesomeIcons.fileInvoice,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseAccountScreen,
                    arguments: {
                      'accounts': accountsController.accounts,
                    },
                  );
                },
              ),
              DrawerListTile(
                title: "الفواتير",
                subtitle: "تصفح و تعديل الفواتير",
                iconData: FontAwesomeIcons.fileInvoice,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.ordersScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "جهات العمل",
                subtitle: "الزبائن والموردين والموزعين والمسوقين",
                iconData: FontAwesomeIcons.person,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseAccountScreen,
                    arguments: {
                      'style': 'employers',
                      'accounts': accountsController.customersAccounts
                    },
                  );
                },
              ),
              DrawerListTile(
                title: "الصناديق النقدية",
                subtitle: "تصفح و تعديل الصناديق النقدية",
                iconData: Ionicons.cart,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chooseAccountScreen,
                    arguments: {
                      'style': 'bank',
                      'accounts': accountsController.bankAccounts
                    },
                  );
                },
              ),
              DrawerListTile(
                title: "تصنيفات البضاعة",
                subtitle: "تصفح و تعديل تصنيفات البضاعة",
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
              DrawerListTile(
                title: "المستودعات",
                subtitle: "تصفح و تعديل المستودعات",
                iconData: Icons.warehouse,
                onTap: () {
                  Get.toNamed(AppRoutes.chooseWareScreen, arguments: {});
                },
              ),
              DrawerListTile(
                title: "الدفعات",
                subtitle: "تصفح و تعديل الدفعات",
                iconData: FontAwesomeIcons.fileInvoiceDollar,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.paymentsScreen,
                  );
                },
              ),
              DrawerListTile(
                title: "الإيرادات والمصاريف",
                subtitle: "تصفح و تعديل الإيرادات والمصاريف",
                iconData: FontAwesomeIcons.fileInvoiceDollar,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.earnsExpensesScreen,
                  );
                },
              ),
              const DrawerListTile(
                title: "التسعير الشامل",
                subtitle: "تعديل كل الأسعار من نافذة واحدة",
                iconData: Ionicons.pricetag,
                onTap: null,
              ),
              DrawerListTile(
                title: "التقارير",
                subtitle: "التقارير المحاسبية",
                iconData: Ionicons.analytics,
                onTap: () => Get.toNamed(AppRoutes.reportsScreen),
              ),
              DrawerListTile(
                title: "المستخدمين",
                subtitle: "تصفح و تعديل المستخدمين",
                iconData: FontAwesomeIcons.user,
                onTap: () {
                  Get.toNamed(AppRoutes.chooseUserScreen);
                },
              ),
              DrawerListTile(
                title: "الإعدادات",
                subtitle: "التعديل في إعدادات التطبيق",
                iconData: Icons.settings,
                onTap: () {
                  Get.toNamed(AppRoutes.settingsScreen);
                },
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
