import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/store_settings.dart';
import 'package:matjary/DataAccesslayer/Repositories/store_settings_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class StoreSettingsController extends GetxController {
  TextEditingController storeNameController = TextEditingController();
  String selectedIconPath = '';
  StoreSettingsRepo repo = StoreSettingsRepo();
  var isLoading = true.obs;

  Future<void> getStoreSettings() async {
    isLoading.value = true;
    StoreSettings? storeSettings = await repo.getStoreSettings();
    isLoading.value = false;
    if (storeSettings != null) MyApp.storeSettings = storeSettings;
  }

  void setStoreName(name) {
    storeNameController.value = TextEditingValue(text: name);
  }

  void setSelectedStoreIconPath(path) {
    selectedIconPath = path;
  }

  void setStoreSettingsToFields() {
    setStoreName(MyApp.storeSettings!.name);
  }

  Future<void> updateStoreSettings() async {
    String name = storeNameController.text;
    isLoading.value = true;
    StoreSettings? storeSettings = await repo.updateStoreSettings(
      name,
      selectedIconPath,
      MyApp.storeSettings!.defaultWare,
      MyApp.storeSettings!.defaultBank,
      MyApp.storeSettings!.currencies,
    );
    isLoading.value = false;
    if (storeSettings != null) {
      MyApp.storeSettings = storeSettings;
      setStoreSettingsToFields();
      SnackBars.showSuccess('تم التعيين بنجاح');
    } else {
      SnackBars.showError('فشل التعيين');
    }
  }
}
