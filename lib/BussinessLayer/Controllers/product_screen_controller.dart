import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/image_picker_helper.dart';

class ProductScreenController extends GetxController {
  bool affected = false;
  bool notAffected = true;
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  List<String> selectedImages = [];

  void setAffectedExchangeState(type) {
    if (type == 'يتأثر') {
      affected = true;
      notAffected = false;
    } else {
      affected = false;
      notAffected = true;
    }
  }

  void changeAffectedExchangeState(type) {
    setAffectedExchangeState(type);
    update();
  }

  void getSelectedImages() async {
    selectedImages.clear();
    selectedImages = await imagePickerHelper.pickImages();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    selectedImages.clear();
  }
}
