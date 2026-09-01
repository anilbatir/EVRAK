import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/curriculum/curriculum_catalog.dart';
import 'package:evrak/data/curriculum/yillik_plan_builder.dart';
import 'package:evrak/models/weekly_plan.dart';
import 'package:evrak/services/template_engine.dart';

final _placeholderPattern = RegExp(r'\{\{\s*([\w.]+)\s*\}\}');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('curriculumCatalog haftalık plan JSON dosyaları yüklenebiliyor', () async {
    for (final combo in curriculumCatalog) {
      final plan = await WeeklyPlan.loadAsset(combo.assetPath);
      expect(plan.grade, combo.grade);
      expect(plan.subject, combo.subject);
      expect(plan.weeks, isNotEmpty);
    }
  });

  test('9. Sınıf Biyoloji: motor tüm 37 haftayı ve farklı kazanımları üretiyor', () async {
    final biyoloji = curriculumCatalog.firstWhere((c) => c.subject == 'Biyoloji');
    final plan = await WeeklyPlan.loadAsset(biyoloji.assetPath);
    final template = buildYillikPlanTemplate(id: biyoloji.yillikPlanTemplateId, plan: plan);

    expect(template.isActive, isTrue);
    expect(template.bodyText, isNotEmpty);

    final placeholders = _placeholderPattern.allMatches(template.bodyText).map((m) => m.group(1)!).toSet();
    final declared = {...template.requiredFields, ...template.optionalFields};
    for (final p in placeholders) {
      expect(declared.contains(p), isTrue, reason: '{{$p}} bildirilmemiş');
    }

    final data = <String, String>{for (final f in declared) f: 'x'};
    final result = TemplateEngine.render(template, data);
    expect(result.isComplete, isTrue);
    expect(result.text.contains('{{'), isFalse);

    for (var i = 1; i <= 37; i++) {
      expect(result.text.contains('$i. Hafta'), isTrue, reason: '$i. Hafta metinde yok');
    }
    expect(result.text.contains('Ara Tatil'), isTrue);
    expect(result.text.contains('Yarıyıl Tatili'), isTrue);

    // Different weeks must carry different kazanım codes (not the "every
    // week repeats week 1" bug the Gemini-generated documents had).
    expect(result.text.contains('BİY.9.1.1'), isTrue);
    expect(result.text.contains('BİY.9.1.7'), isTrue);
    expect(result.text.contains('BİY.9.2.1'), isTrue);
    expect(result.text.contains('BİY.9.2.8'), isTrue);

    // The notes/EK-1 sections the teacher asked to drop must not appear.
    expect(result.text.contains('Önemli uygulama notları'), isFalse);
    expect(result.text.contains('EK-1'), isFalse);
    expect(result.text.contains('Kaynaklar'), isFalse);
  });
}
