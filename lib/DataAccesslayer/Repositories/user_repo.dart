import 'dart:convert';
import '../Clients/user_client.dart';
import '../Models/user.dart';

class UserRepo {
  var client = UserClient();

  Future<User?> login(email, password) async {
    var data = await client.login(email, password);
    if (data != null) {
      return User.fromMap(jsonDecode(data));
    }
    return null;
  }

  Future<bool?> createUser(
      type, userName, mobilePhone, password, notifiable) async {
    var createdUser = await client.createUser(
        type, userName, mobilePhone, password, notifiable);
    if (createdUser != null) {
      return true;
    }
    return null;
  }

  Future<User?> updateUserInfo(userName, mobilePhone, password, avatar) async {
    var response =
        await client.updateUserInfo(userName, mobilePhone, password, avatar);
    if (response != null) {
      final parsed = json.decode(response);
      return User.fromMap(parsed);
    }
    return null;
  }
}
