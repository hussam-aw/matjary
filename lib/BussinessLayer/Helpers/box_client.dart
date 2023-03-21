import 'package:get_storage/get_storage.dart';

class BoxClient {
  final box = GetStorage();

  Future<bool> checkAuthed() async {
    return await box.read('authed') ?? false;
  }

  Future<void> setAuthed() async {
    await box.write('authed', true);
  }
}
