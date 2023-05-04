import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker picker = ImagePicker();
  List<XFile> selectedImages = [];
  List<String> imagePaths = [];

  Future<List<String>> pickImages() async {
    selectedImages = await picker.pickMultiImage();

    for (XFile file in selectedImages) {
      imagePaths.add(file.path);
    }
    return imagePaths;
  }
}
