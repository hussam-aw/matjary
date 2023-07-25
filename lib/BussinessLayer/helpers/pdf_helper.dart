import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

class PdfHelper {
  static p.Font? font;

  Future<bool> createPdf(fileName, List<p.Widget> w) async {
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
    try {
      final output = await getExternalStorageDirectory();
      final file = File(
        "${output!.path}/$fileName.pdf",
      );
      await file.writeAsBytes(await pdf.save());
    } catch (err) {
      return false;
    }
    return true;
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
