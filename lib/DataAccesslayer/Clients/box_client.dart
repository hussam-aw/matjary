import 'package:get_storage/get_storage.dart';
import '../Models/user.dart';
import '../Models/ware.dart';

class BoxClient {
  var box = GetStorage();
  Future<bool> getAuthState() async {
    print( box.read('authed'));
    if (await box.read('authed') != null) {
      return true;
    }
    return false;
  }

  Future<User> getAuthedUser() async {
    return User.fromBoxMap(await box.read('userdata'));
  }

  Future<void> setAuthedUser(User user) async {
    await box.write('authed', true);
    await box.write('userdata', user.toMap());
  }

  Future<void> removeUserData() async {
    await box.remove('authed');
    await box.remove('userdata');
  }

  Future<void> addWare(List<Ware> userWares) async {
    await box.remove('user_wares');
    var map = userWares.map((e) => e.toMap());
    await box.write('user_wares', map.toList());
  }
  Future<void> removeAllWares() async {
    await box.remove('user_wares');
  }
}
