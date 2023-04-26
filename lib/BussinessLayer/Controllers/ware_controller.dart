import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../DataAccesslayer/Models/ware.dart';
import '../../DataAccesslayer/Repositories/ware_repo.dart';
import '../../PresentationLayer/Widgets/snackbars.dart';
import '../../main.dart';

class WareController extends GetxController {
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  var adding = false.obs;
  TextEditingController nameOfWareController = TextEditingController();

  Future<void> addWare() async {
    adding.value = true;
    Ware? ware = await wareRepo.postWare(
        nameOfWareController.value.text, MyApp.appUser!.id);
    adding.value = false;
    update();
    if (ware == null) {
      SnackBars.showSuccess('حدث خطأ أثناء الإضافة');
    } else {
      SnackBars.showSuccess('تمت إضافة مستودع جديد');
    }
  }
}
