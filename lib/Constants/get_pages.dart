import 'package:get/get.dart';
import 'package:matjary/PresentationLayer/Auth/login_screen.dart';
import 'package:matjary/PresentationLayer/Auth/register_screen.dart';
import 'package:matjary/PresentationLayer/Private/choose_account_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_account_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_bank_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_category_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_client_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_product_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_ware.dart';
import 'package:matjary/PresentationLayer/Private/create_statement.dart';
import 'package:matjary/PresentationLayer/Public/home_screen.dart';
import '../PresentationLayer/Public/splash_screen.dart';
import 'get_routes.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.splashscreen, page: () => SplashScreen()),
  GetPage(name: AppRoutes.loginscreen, page: () => const LoginScreen()),
  GetPage(name: AppRoutes.registerscreen, page: () => const RegisterScreen()),
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
  GetPage(
      name: AppRoutes.createEditAccountScreen,
      page: () => const CreateEditAccountScreen()),
  GetPage(
      name: AppRoutes.createEditWareScreen,
      page: () => const CreateEditWareScreen()),
  GetPage(
      name: AppRoutes.createEditBankScreen,
      page: () => const CreateEditBankScreen()),
  GetPage(
      name: AppRoutes.createEditClientScreen,
      page: () => const CreateEditClientScreen()),
  GetPage(
      name: AppRoutes.createEditProductScreen,
      page: () => const CreateEditProductScreen()),
  GetPage(
      name: AppRoutes.createEditCategoryScreen,
      page: () => const CreateEditCategoryScreen()),
  GetPage(
      name: AppRoutes.createStatementScreen,
      page: () => const CreateStatementScreen()),
  GetPage(
      name: AppRoutes.chooseAccountScreen,
      page: () => const ChooseAccountScreen()),
];
