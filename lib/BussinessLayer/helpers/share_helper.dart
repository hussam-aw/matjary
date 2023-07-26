import 'package:share_plus/share_plus.dart';

class ShareHelper {
  Future<void> shareFile(filePath) async {
    Future.delayed(
      const Duration(seconds: 2),
      () async => await Share.shareXFiles([XFile(filePath)]),
    );
  }
}
