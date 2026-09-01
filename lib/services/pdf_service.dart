import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<File> generateDocumentPdf({
    required String title,
    required String bodyText,
    String? headerText,
  }) async {
    final regularData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final regularFont = pw.Font.ttf(regularData);
    final boldFont = pw.Font.ttf(boldData);

    final doc = pw.Document();
    final paragraphs = bodyText.split('\n');
    final resolvedHeaderText = headerText ?? title;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(56, 40, 56, 56),
        theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
        header: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(bottom: 12),
          padding: const pw.EdgeInsets.only(bottom: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(width: 0.6, color: PdfColors.grey500)),
          ),
          child: pw.Text(
            resolvedHeaderText,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 9.5, color: PdfColors.grey700, font: boldFont),
          ),
        ),
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
