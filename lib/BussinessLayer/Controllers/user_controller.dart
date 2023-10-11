import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/users_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/user.dart';
import 'package:matjary/DataAccesslayer/Repositories/user_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class UserController extends GetxController {
  int? userType = 0;
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int? notifiable = 1;
  final usersController = Get.find<UsersController>();
  UserRepo userRepo = UserRepo();
  var isLoading = false.obs;
  var savingState = false;
  final connectivityController = Get.find<ConnectivityController>();
  BoxClient boxClient = BoxClient();

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

  Future<void> createUser() async {
    savingState = false;
    String userName = getUserName();
    String mobilePhone = getMobilePhone();
    String password = getPassword();
    if (userName.isNotEmpty && mobilePhone.isNotEmpty && password.isNotEmpty) {
      if (connectivityController.isConnected) {
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
          usersController.getUsers();
          savingState = true;
          setUserDetails(null);
          SnackBars.showSuccess('تم انشاء المستخدم');
        } else {
          SnackBars.showError('فشل انشاء المستخدم');
        }
      } else {
        SnackBars.showError('لا يوجد اتصال بالانترنت');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateUserData(id) async {
    User? user = await userRepo.getUserDataById(id);
    if (user != null) {
      MyApp.appUser = user;
      await boxClient.setAuthedUser(user);
    }
  }
}
