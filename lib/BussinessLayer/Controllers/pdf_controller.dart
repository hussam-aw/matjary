import 'dart:io';

import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/pdf_helper.dart';
import 'package:matjary/BussinessLayer/helpers/share_helper.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class PdfController extends GetxController {
  PdfHelper pdfHelper = PdfHelper();
  ShareHelper shareHelper = ShareHelper();

  Future<void> saveToPdfFile({fileName, widgetList}) async {
    File? savedFile = await pdfHelper.createPdf(fileName, widgetList);
    if (savedFile != null) {
      SnackBars.showSuccess('تم الحفظ بنجاح');
      await shareHelper.shareFile(savedFile.path);
    } else {
      SnackBars.showWarning('لم يتم حفظ الملف');
    }
  }

  @override
  void onInit() async {
    await PdfHelper.getPrintFont();
    super.onInit();
  }
}
