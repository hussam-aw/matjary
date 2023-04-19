import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../DataAccesslayer/Models/ware.dart';
import '../../DataAccesslayer/Repositories/ware_repo.dart';
import '../../PresentationLayer/Widgets/snackbars.dart';
import '../../main.dart';
import '../Helpers/box_client.dart';



class WareController extends GetxController{
  BoxClient boxClient = BoxClient();
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  var adding = false.obs;
TextEditingController nameOfWareController = TextEditingController();

  Future<void> addWare() async {
    adding.value = true;
      wares = (await wareRepo.postWare(nameOfWareController.value.text,
          MyApp.appUser!.id));
    adding.value = false;
    update();
    SnackBars.showSuccess('تمت إضافة مستودع جديد');
  }
}