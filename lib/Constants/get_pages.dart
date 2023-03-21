import 'package:get/get.dart';
import 'package:matjary/PresentationLayer/Auth/login_screen.dart';
import '../PresentationLayer/Public/splash_screen.dart';
import 'get_routes.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.splashscreen, page: () => SplashScreen()),
  GetPage(name: AppRoutes.loginscreen, page: () => const LoginScreen()),
];
