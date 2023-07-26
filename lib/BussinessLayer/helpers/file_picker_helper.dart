import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  Future<String?> pickFolder() async {
    return await FilePicker.platform.getDirectoryPath();
  }
}
