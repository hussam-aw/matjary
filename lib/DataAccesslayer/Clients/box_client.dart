import 'package:get_storage/get_storage.dart';

import '../Models/user.dart';

class BoxClient {
  var box = GetStorage();
  Future<bool> getAuthState() async {
    print(box.read('matjary_authed'));
    if (await box.read('matjary_authed') != null) {
      return true;
    }
    return false;
  }

  Future<User> getAuthedUser() async {
    return User.fromBoxMap(await box.read('matjary_userdata'));
  }

  Future<void> setAuthedUser(User user) async {
    print("Get Storage Write User Start");
    await box.write('matjary_authed', true);
    await box.write('matjary_userdata', user.toMap());
    print("Get Storage Write User End");
  }

  Future<void> removeUserData() async {
    await box.remove('matjary_authed');
    await box.remove('matjary_userdata');
  }
}
