import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/helpers/pdf_helper.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class PdfController extends GetxController {
  PdfHelper pdfHelper = PdfHelper();

  Future<void> saveToPdfFile({fileName, widgetList}) async {
    bool successSaving = await pdfHelper.createPdf(fileName, widgetList);
    if (successSaving) {
      SnackBars.showSuccess('تم الحفظ بنجاح');
    } else {
      SnackBars.showError('فشل الحفظ');
    }
  }

  @override
  void onInit() async {
    await PdfHelper.getPrintFont();
    super.onInit();
  }
}
