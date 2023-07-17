import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfHelper {
  final pdf = Document();

  void createPdf() async {
    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          print('ali');
          return Center(
            child: Text('ali'),
          );
        },
      ),
    );
    final output = await getApplicationDocumentsDirectory();
    print(output.path);
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
