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
  late List<Ware> ware;
  var adding = false.obs;
TextEditingController nameOfWareController = TextEditingController();

  Future<void> addWare() async {
    adding.value = true;
      wares = (await wareRepo.postWare(
          MyApp.appUser!.id, nameOfWareController.value.text));
      //wares.add(ware);
    adding.value = false;
    update();
    SnackBars.showSuccess('تمت إضافة مستودع جديد');
  }
}