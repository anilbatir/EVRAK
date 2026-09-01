import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/weekly_plan.dart';

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

  /// Renders a Yıllık Plan as an actual table (Ay/Hafta/Tarih/Saat/Ünite/
  /// Kazanım/İçerik/Ölçme/Belirli Gün-Hafta columns, one row per week) -
  /// matching the format teachers actually submit, instead of free-flowing
  /// paragraph text. [teacherName]/[branch]/[schoolName]/[principalName]
  /// are already-resolved (placeholder-free) values from the prepare form.
  static Future<File> generateYillikPlanPdf({
    required String title,
    required WeeklyPlan plan,
    required String teacherName,
    required String branch,
    required String schoolName,
    String? principalName,
  }) async {
    final regularData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final regularFont = pw.Font.ttf(regularData);
    final boldFont = pw.Font.ttf(boldData);

    final rows = <List<String>>[];
    for (final week in plan.weeks) {
      if (week.isHoliday) {
        rows.add([week.month ?? '', week.weekLabel, week.dateRange ?? '', '', '', '', '', '', '']);
        continue;
      }
      final kazanimText = week.kazanimlar
          .map((k) {
            final kod = (k.kod ?? '').isNotEmpty ? '${k.kod} ' : '';
            final saat = (k.saat ?? '').isNotEmpty ? ' (${k.saat} Saat)' : '';
            return '$kod${k.kazanim}$saat';
          })
          .join('\n');
      final icerikText = week.kazanimlar
          .map((k) => k.resmiAciklama ?? '')
          .where((s) => s.isNotEmpty)
          .join('\n');
      rows.add([
        week.month ?? '',
        week.weekLabel,
        week.dateRange ?? '',
        week.hours ?? '',
        week.topic != null && week.topic!.isNotEmpty ? '${week.unit ?? ''}\n${week.topic}' : (week.unit ?? ''),
        kazanimText,
        icerikText,
        week.olcme ?? '',
        week.aciklama ?? '',
      ]);
    }

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.fromLTRB(24, 28, 24, 28),
        theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
        build: (context) => [
          pw.Text(title, style: pw.TextStyle(fontSize: 13, font: boldFont)),
          pw.SizedBox(height: 4),
          pw.Text(
            'Öğretmen: $teacherName   Branş: $branch   Okul: $schoolName${principalName != null && principalName.isNotEmpty ? '   Okul Müdürü: $principalName' : ''}',
            style: const pw.TextStyle(fontSize: 9),
          ),
          pw.SizedBox(height: 10),
          pw.TableHelper.fromTextArray(
            headers: const ['Ay', 'Hafta', 'Tarih', 'Saat', 'Ünite/Konu', 'Kazanım', 'İçerik/Açıklama', 'Ölçme', 'Belirli Gün-Hafta'],
            data: rows,
            headerStyle: pw.TextStyle(fontSize: 8, font: boldFont, color: PdfColors.white),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey700),
            cellStyle: const pw.TextStyle(fontSize: 7.5),
            cellPadding: const pw.EdgeInsets.all(4),
            cellAlignment: pw.Alignment.topLeft,
            border: pw.TableBorder.all(width: 0.4, color: PdfColors.grey500),
            columnWidths: const {
              0: pw.FlexColumnWidth(1.1),
              1: pw.FlexColumnWidth(1.3),
              2: pw.FlexColumnWidth(1.6),
              3: pw.FlexColumnWidth(0.7),
              4: pw.FlexColumnWidth(1.8),
              5: pw.FlexColumnWidth(3),
              6: pw.FlexColumnWidth(3),
              7: pw.FlexColumnWidth(2),
              8: pw.FlexColumnWidth(1.8),
            },
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
