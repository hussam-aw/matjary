import 'dart:io';
import 'package:flutter/services.dart';
import 'package:matjary/BussinessLayer/helpers/file_picker_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

class PdfHelper {
  static p.Font? font;
  FilePickerHelper filePickerHelper = FilePickerHelper();

  Future<File?> createPdf(fileName, List<p.Widget> w) async {
    String? selectedFolder = await filePickerHelper.pickFolder();
    if (selectedFolder != null) {
      final pdf = p.Document();

      pdf.addPage(
        p.MultiPage(
          maxPages: 200,
          pageFormat: PdfPageFormat.a4,
          build: (p.Context context) {
            return w;
          },
        ),
      );

      return await savePdfToFile(selectedFolder, fileName, pdf);
    }
    return null;
  }

  Future<File> savePdfToFile(directory, fileName, pdf) async {
    print("$directory/$fileName.pdf");
    final file = File("$directory/$fileName.pdf");
    return await file.writeAsBytes(await pdf.save());
  }

  static Future<void> getPrintFont() async {
    font =
        p.Font.ttf(await rootBundle.load('assets/fonts/NotoNaskhArabic.ttf'));
  }

  static Future<Uint8List> getAssetBytes(asset) async {
    ByteData bytes = await rootBundle.load(asset);
    return bytes.buffer.asUint8List();
  }
}
