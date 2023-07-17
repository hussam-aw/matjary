import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Repositories/user_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class ProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserRepo userRepo = UserRepo();
  BoxClient client = BoxClient();
  var isLoading = false.obs;

  Future<void> updateProfile() async {
    String userName = userNameController.text;
    String mobilePhone = mobileNumberController.text;
    String password = passwordController.text;
    if (userName.isNotEmpty && mobilePhone.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;
      var user =
          await userRepo.updateUserInfo(userName, mobilePhone, password, '');
      isLoading.value = false;
      if (user != null) {
        MyApp.appUser = user;
        await client.setAuthedUser(user);
        update();
        SnackBars.showSuccess('تم تعديل بيانات الملف الشخصي');
      } else {
        SnackBars.showError('فشل التعديل');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }
}
