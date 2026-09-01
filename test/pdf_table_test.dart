import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:evrak/models/weekly_plan.dart';
import 'package:evrak/services/pdf_service.dart';

class _FakePathProvider extends PathProviderPlatform {
  _FakePathProvider(this.dir);
  final Directory dir;

  @override
  Future<String?> getApplicationDocumentsPath() async => dir.path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generateYillikPlanPdf bir haftalık plandan gerçek PDF üretir', () async {
    final tmpDir = await Directory.systemTemp.createTemp('evrak_pdf_test');
    PathProviderPlatform.instance = _FakePathProvider(tmpDir);
    addTearDown(() => tmpDir.delete(recursive: true));

    final plan = await WeeklyPlan.loadAsset('assets/plans/9-biyoloji.json');
    final file = await PdfService.generateYillikPlanPdf(
      title: 'Yıllık Plan — 9. Sınıf Biyoloji',
      plan: plan,
      teacherName: 'Ayşe Yılmaz',
      branch: 'Biyoloji',
      schoolName: 'Örnek Anadolu Lisesi',
      principalName: 'Mehmet Demir',
    );

    expect(file.existsSync(), isTrue);
    // A one-row-per-week table for 37+3 weeks spans several A4 pages; a
    // trivial single-page flat-text PDF would be far smaller than this.
    expect(file.lengthSync(), greaterThan(20000));
  });
}
