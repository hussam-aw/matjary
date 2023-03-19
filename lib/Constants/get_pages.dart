import 'package:get/get.dart';
import '../PresentationLayer/Public/splash_screen.dart';
import 'get_routes.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.splashscreen, page: () => const SplashScreen()),
];
