import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<File> generateDocumentPdf({
    required String title,
    required String bodyText,
  }) async {
    final regularData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final regularFont = pw.Font.ttf(regularData);
    final boldFont = pw.Font.ttf(boldData);

    final doc = pw.Document();
    final paragraphs = bodyText.split('\n');

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(56, 56, 56, 56),
        theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
        build: (context) => [
          for (final line in paragraphs)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Text(
                line,
                style: const pw.TextStyle(fontSize: 12, lineSpacing: 3),
              ),
            ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final safeName = title.replaceAll(RegExp(r'[^\w\sğüşıöçĞÜŞİÖÇ-]'), '').trim();
    final file = File('${dir.path}/$safeName-${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await doc.save());
    return file;
  }
}
