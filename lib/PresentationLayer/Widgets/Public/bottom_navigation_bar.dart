import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        color: UIColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: const Icon(
                  size: 28,
                  FontAwesomeIcons.houseChimney,
                  color: UIColors.white,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(
                  size: 28,
                  FontAwesomeIcons.bell,
                  color: UIColors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.notificationsScreen);
                },
              ),
            ),
            const Expanded(child: Text('')),
            Expanded(
              child: IconButton(
                icon: const Icon(
                  size: 28,
                  Ionicons.analytics,
                  color: UIColors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.reportsScreen);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(
                  size: 28,
                  Ionicons.person,
                  color: UIColors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.profileScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
