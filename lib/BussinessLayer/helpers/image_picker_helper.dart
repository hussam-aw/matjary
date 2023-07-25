import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker picker = ImagePicker();
  List<XFile> selectedImages = [];
  XFile? selectedImage;
  List<String> imagePaths = [];

  Future<List<String>> pickImages() async {
    selectedImages = await picker.pickMultiImage();
    for (XFile file in selectedImages) {
      imagePaths.add(file.path);
    }
    return imagePaths;
  }

  Future<String> pickImage() async {
    selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      return selectedImage!.path;
    }
    return '';
  }
}
