import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker picker = ImagePicker();
  List<XFile> selectedImages = [];
  Future<List<XFile>> pickImages() async {
    selectedImages = await picker.pickMultiImage();
    return selectedImages;
  }
}
