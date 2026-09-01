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

  test('bir haftada birden fazla kazanım (saat paylaşımlı) doğru render edilir', () {
    final plan = WeeklyPlan.fromJson({
      'grade': '12',
      'subject': 'Matematik',
      'academicYear': '2026-2027',
      'weeks': [
        {
          'weekLabel': '2. Hafta',
          'dateRange': '15-19 Eylül',
          'hours': '6',
          'unit': 'SAYILAR VE CEBİR',
          'topic': 'Üstel ve Logaritmik Fonksiyonlar',
          'kazanimlar': [
            {'kod': '12.1.1.1', 'kazanim': 'Üstel fonksiyonu açıklar.', 'saat': '2'},
            {
              'kod': '12.1.2.1',
              'kazanim': 'Logaritma fonksiyonu ile üstel fonksiyonu ilişkilendirerek problemler çözer.',
              'resmiAciklama': 'a) Logaritma fonksiyonunun grafiği üstel fonksiyonun grafiğinden yararlanarak çizilir.',
              'saat': '4',
            },
          ],
          'yontemTeknik': 'Kavram Haritası, Anlatım, Soru-Cevap',
          'aciklama': 'Gaziler Günü',
          'isHoliday': false,
        },
      ],
    });

    final week = plan.weeks.single;
    expect(week.kazanimlar, hasLength(2));
    expect(week.kazanimlar[0].saat, '2');
    expect(week.kazanimlar[1].saat, '4');

    final template = buildYillikPlanTemplate(id: 'PLN-TEST', plan: plan);
    expect(template.bodyText.contains('12.1.1.1 Üstel fonksiyonu açıklar. (2 Saat)'), isTrue);
    expect(template.bodyText.contains('12.1.2.1 Logaritma fonksiyonu ile üstel fonksiyonu ilişkilendirerek problemler çözer. (4 Saat)'), isTrue);
    expect(template.bodyText.contains('a) Logaritma fonksiyonunun grafiği'), isTrue);
    expect(template.bodyText.contains('Yöntem-Teknik: Kavram Haritası'), isTrue);
    expect(template.bodyText.contains('Konu: Üstel ve Logaritmik Fonksiyonlar'), isFalse); // rendered inline in the week header, not as a separate line
  });
}
