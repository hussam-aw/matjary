import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Helpers/box_client.dart';
import 'package:matjary/Constants/get_routes.dart';

import '../../main.dart';

class SplashController extends GetxController {
  final BoxClient boxClient = BoxClient();

  Future<void> checkAuthed() async {
    bool authed = await boxClient.getAuthState();
    if (authed == true) {
      MyApp.appUser = await boxClient.getAuthedUser();
      Future.delayed(const Duration(seconds: 3))
          .then((value) => Get.offAndToNamed(AppRoutes.homeScreen));
    } else {
      Future.delayed(const Duration(seconds: 3))
          .then((value) => Get.offAndToNamed(AppRoutes.loginScreen));
    }
  }

  @override
  void onInit() async{
   await checkAuthed();
    super.onInit();
  }
}
