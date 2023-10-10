import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';

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
  final connectivityController = Get.find<ConnectivityController>();

  Future<void> login() async {
    if (loginEmailController.value.text.isNotEmpty &&
        loginPasswordController.value.text.isNotEmpty) {
      if (connectivityController.isConnected) {
        logging.value = true;
        User? user = await userRepo.login(loginEmailController.value.text,
            loginPasswordController.value.text);
        if (user != null) {
          MyApp.appUser = user;
          logging.value = false;
          await client.setAuthedUser(user);
          SnackBars.showSuccess("${'أهلاً بك  : '}${user.name}");
          Get.toNamed(AppRoutes.homeScreen);
        } else {
          SnackBars.showWarning('بياناتك لا تتطابق مع سجلاتنا');
        }
      } else {
        SnackBars.showError('لا يوجد اتصال بالانترنت');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة للمتابعة');
    }
  }

  Future<void> logout() async {
    await boxClient.clearStorage();
    MyApp.appUser = null;
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}
