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
  Future<void> login() async {
    logging.value = true;
    if (loginEmailController.value.text.isNotEmpty &&
        loginPasswordController.value.text.isNotEmpty) {
      User? user = await userRepo.login(
          loginEmailController.value.text, loginPasswordController.value.text);
      if (user != null) {
        MyApp.appUser = user;
        await client.setAuthedUser(user);
        SnackBars.showSuccess("${'أهلاً بك'.tr}${user.name}");
        Get.toNamed(AppRoutes.homeScreen);
      } else {
        SnackBars.showWarning('بياناتك لا تتطابق مع سجلاتنا'.tr);
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة للمتابعة'.tr);
    }
    logging.value = false;
  }

}
