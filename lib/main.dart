import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matjary/Constants/get_pages.dart';
import 'package:matjary/DataAccesslayer/Models/store_settings.dart';

import 'DataAccesslayer/Models/user.dart';

void main() async {
  await GetStorage.init();
    HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  /*  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 500;
  } */

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
