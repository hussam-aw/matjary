import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Constants/get_routes.dart';
import '../../DataAccesslayer/Clients/box_client.dart';
import '../../DataAccesslayer/Models/user.dart';
import '../../DataAccesslayer/Repositories/user_repo.dart';
import '../../PresentationLayer/Widgets/snackbars.dart';
import '../../main.dart';

class AuthController extends GetxController {
  UserRepo userRepo = UserRepo();
  BoxClient client = BoxClient();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  var logging = false.obs;
  BoxClient boxClient = BoxClient();
  Future<void> login() async {
    logging.value = true;
    if (loginEmailController.value.text.isNotEmpty &&
        loginPasswordController.value.text.isNotEmpty) {
      User? user = await userRepo.login(
          loginEmailController.value.text, loginPasswordController.value.text);

      if (user != null) {
        print("user not null");
        MyApp.appUser = user;
        await client.setAuthedUser(user);
        SnackBars.showSuccess("${'أهلاً بك'}${user.name}");
        Get.toNamed(AppRoutes.homeScreen);
      } else {
        SnackBars.showWarning('بياناتك لا تتطابق مع سجلاتنا');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة للمتابعة');
    }
    logging.value = false;
  }

  Future<void> logout() async {
    await boxClient.removeUserData();
    MyApp.appUser = null;
    Get.toNamed(AppRoutes.loginScreen);
  }
}
