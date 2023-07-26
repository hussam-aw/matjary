import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/user.dart';
import 'package:matjary/DataAccesslayer/Repositories/user_repo.dart';

class UsersController extends GetxController {
  UserRepo userRepo = UserRepo();
  List<User> users = [];
  var isLoadingUsers = false.obs;

  Future<void> getUsers() async {
    isLoadingUsers.value = true;
    users = await userRepo.getUsers();
    isLoadingUsers.value = false;
  }
}
