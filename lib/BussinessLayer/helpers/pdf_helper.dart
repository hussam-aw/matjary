import 'dart:io';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

class PdfHelper {
  final pdf = p.Document();

  void createPdf() async {
    pdf.addPage(
      p.Page(
        pageFormat: PdfPageFormat.a4,
        build: (p.Context context) {
          return p.Center(
            child: p.Text("Hello World"),
          );
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    final file = File(
      "${output!.path}/example.pdf",
    );
    print(file.path);
    await file.writeAsBytes(await pdf.save());
  }
}
