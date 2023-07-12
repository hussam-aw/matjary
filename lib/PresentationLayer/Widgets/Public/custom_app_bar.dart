import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';

PreferredSize customAppBar(
    {bool showDrawer = true,
    bool showingAppIcon = true,
    List<Widget> actions = const []}) {
  return PreferredSize(
    preferredSize: Size(Get.width, 80),
    child: AppBar(
      elevation: 0.0,
      backgroundColor: UIColors.mainBackground,
      flexibleSpace: showingAppIcon
          ? Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            )
          : Container(),
      leading: showDrawer
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  padding: const EdgeInsets.only(top: 15, right: 40),
                  icon: const Icon(
                    Icons.menu,
                    size: 35,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            )
          : null,
      actions: actions,
    ),
  );
}
