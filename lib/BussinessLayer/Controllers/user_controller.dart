import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:matjary/DataAccesslayer/Repositories/user_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class UserController extends GetxController {
  int? userType = 0;
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int? notifiable = 1;
  UserRepo userRepo = UserRepo();
  var isLoading = false.obs;

  Map<String, int> counterUserTypes = {
    'مسؤول': 0,
    'محرر': 1,
  };

  Map<String, int> counterNotifiableTypes = {
    'استلام اشعارات': 1,
    'بدون اشعارات': 0,
  };

  void setUserType(type) {
    userType = counterUserTypes[type];
  }

  void setNotifiableType(type) {
    notifiable = counterNotifiableTypes[type];
  }

  Future<void> createUser() async {
    String userName = userNameController.text;
    String mobilePhone = mobileNumberController.text;
    String password = passwordController.text;
    if (userName.isNotEmpty && mobilePhone.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;
      var user = await userRepo.createUser(
        userType,
        userName,
        mobilePhone,
        password,
        notifiable,
      );
      isLoading.value = false;
      if (user != null) {
        SnackBars.showSuccess('تم انشاء المستخدم');
      } else {
        SnackBars.showError('فشل انشاء المستخدم');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }
}
