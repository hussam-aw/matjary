import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import '../../DataAccesslayer/Models/ware.dart';
import '../../DataAccesslayer/Repositories/ware_repo.dart';
import '../../PresentationLayer/Widgets/snackbars.dart';

class WareController extends GetxController {
  TextEditingController wareNameController = TextEditingController();
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  WaresController waresController = Get.find<WaresController>();
  var loading = false.obs;
  var savingState = false;

  void setWareName(name) {
    if (name.isNotEmpty) {
      wareNameController.value = TextEditingValue(text: name);
    } else {
      wareNameController.clear();
    }
  }

  String getWareName() {
    return wareNameController.value.text;
  }

  void setWareDetails(Ware? ware) {
    if (ware != null) {
      setWareName(ware.name);
    } else {
      setWareName('');
    }
  }

  Future<void> craeteWare() async {
    savingState = false;
    String wareName = getWareName();
    if (wareName.isNotEmpty) {
      setWareDetails(null);
      loading.value = true;
      Ware? ware = await wareRepo.craeteWare(wareName);
      loading.value = false;
      if (ware != null) {
        waresController.getWares();
        savingState = true;
        SnackBars.showSuccess('تمت إضافة مستودع جديد');
      } else {
        SnackBars.showError('حدث خطأ أثناء الإضافة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateWare(int id) async {
    String wareName = getWareName();
    if (wareName.isNotEmpty) {
      setWareDetails(null);
      loading.value = true;
      var account = await wareRepo.updateWare(id, wareName);
      loading.value = false;
      if (account != null) {
        waresController.getWares();
        SnackBars.showSuccess('تم التعديل بنجاح');
      } else {
        SnackBars.showError('فشل التعديل');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> deleteWare(id) async {
    loading.value = true;
    var ware = await wareRepo.deleteWare(id);
    loading.value = false;
    if (ware != null) {
      waresController.getWares();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
