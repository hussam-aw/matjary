import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreenController extends GetxController {
  bool affected = false;
  bool notAffected = true;
  List<XFile>? imageFileList;
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

  Future<void> pickImage() async {
    print("start pick Images");
    ImagePicker picker = ImagePicker();
    imageFileList = await picker.pickMultiImage();
    update();
    print(imageFileList);
  }
}
