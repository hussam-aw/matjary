import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/image_picker_helper.dart';

class StoreSettingsScreenController extends GetxController {
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  RxString selectedStoreIcon = ''.obs;

  void getSelectedStoreImage() async {
    selectedStoreIcon.value = await imagePickerHelper.pickImage();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
