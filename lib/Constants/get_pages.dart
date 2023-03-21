import 'package:get/get.dart';
import 'package:matjary/PresentationLayer/Auth/login_screen.dart';
import 'package:matjary/PresentationLayer/Auth/register_screen.dart';
import 'package:matjary/PresentationLayer/Public/home_screen.dart';
import '../PresentationLayer/Public/splash_screen.dart';
import 'get_routes.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.splashscreen, page: () => SplashScreen()),
  GetPage(name: AppRoutes.loginscreen, page: () => const LoginScreen()),
  GetPage(name: AppRoutes.registerscreen, page: () => const RegisterScreen()),
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
];
