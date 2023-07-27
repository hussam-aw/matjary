import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/user.dart';
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

  void setUserName(name) {
    if (name.isNotEmpty) {
      userNameController.value = TextEditingValue(text: name);
    } else {
      userNameController.clear();
    }
  }

  String getUserName() {
    return userNameController.value.text;
  }

  void setMobilePhone(mobilePhone) {
    if (mobilePhone.isNotEmpty) {
      mobileNumberController.value = TextEditingValue(text: mobilePhone);
    } else {
      mobileNumberController.clear();
    }
  }

  String getMobilePhone() {
    return mobileNumberController.value.text;
  }

  void setPassword(password) {
    if (password.isNotEmpty) {
      passwordController.value = TextEditingValue(text: password);
    } else {
      passwordController.clear();
    }
  }

  String getPassword() {
    return passwordController.value.text;
  }

  void setUserDetails(User? user) {
    if (user != null) {
      setUserName(user.name);
      setMobilePhone(user.mobileNumber);
      setPassword('');
    } else {
      setUserName('');
      setMobilePhone('');
      setPassword('');
    }
  }

  Future<void> updateProfile() async {
    String userName = getUserName();
    String mobilePhone = getMobilePhone();
    String password = getPassword();
    if (userName.isNotEmpty && mobilePhone.isNotEmpty && password.isNotEmpty) {
      //setUserDetails(null);
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
