import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: UIColors.primary,
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: UIColors.containerBackground),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: UIColors.lightNormalText,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                accountName: Text("Ali"),
                accountEmail: Text("Ali@store.com"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
