import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/Constants/get_pages.dart';
import 'package:matjary/PresentationLayer/Auth/pin_code_screen.dart';
import 'package:matjary/PresentationLayer/Auth/register_screen.dart';
import 'package:matjary/PresentationLayer/Public/home_screen.dart';

import 'DataAccesslayer/Models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static User? appUser;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matjary',
      getPages: getPages,
    );
  }
}
