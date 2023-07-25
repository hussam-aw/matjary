import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matjary/Constants/get_pages.dart';
import 'package:matjary/DataAccesslayer/Models/store_settings.dart';

import 'DataAccesslayer/Models/user.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static User? appUser;
  static StoreSettings? storeSettings;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matjary',
      getPages: getPages,
    );
  }
}
