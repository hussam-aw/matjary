import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';

import '../../DataAccesslayer/Models/ware.dart';
import '../../DataAccesslayer/Repositories/ware_repo.dart';
import '../../PresentationLayer/Widgets/snackbars.dart';
import '../../main.dart';

class WareController extends GetxController {
  TextEditingController nameOfWareController = TextEditingController();
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  var adding = false.obs;
  HomeController homeController = Get.find<HomeController>();

  void setWareDetails(Ware? ware) {
    if (ware != null) {
      nameOfWareController = TextEditingController(text: ware.name);
    }
  }

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

  Future<void> updateWare(int id) async {
    var account = await wareRepo.updateWare(id, nameOfWareController.text);
    if (account != null) {
      homeController.getWares();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteWare(id) async {
    var ware = await wareRepo.deleteWare(id);
    if (ware != null) {
      homeController.getWares();
      SnackBars.showSuccess('تم الحذف بنجاح');
      update();
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
