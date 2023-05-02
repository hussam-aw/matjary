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
  var loading = false.obs;
  HomeController homeController = Get.find<HomeController>();

  void setWareDetails(Ware? ware) {
    if (ware != null) {
      nameOfWareController = TextEditingController(text: ware.name);
    }
  }

  Future<void> addWare() async {
    loading.value = true;
    Ware? ware = await wareRepo.postWare(
        nameOfWareController.value.text, MyApp.appUser!.id);
    loading.value = false;

    if (ware == null) {
      SnackBars.showSuccess('حدث خطأ أثناء الإضافة');
    } else {
      homeController.getWares();
      SnackBars.showSuccess('تمت إضافة مستودع جديد');
    }
  }

  Future<void> updateWare(int id) async {
    loading.value = true;
    var account = await wareRepo.updateWare(id, nameOfWareController.text);
    loading.value = false;
    if (account != null) {
      homeController.getWares();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteWare(id) async {
    loading.value = true;
    var ware = await wareRepo.deleteWare(id);
    loading.value = false;
    if (ware != null) {
      homeController.getWares();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
