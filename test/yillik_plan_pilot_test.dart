import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/yillik_plan_pilot.dart';
import 'package:evrak/models/document.dart';
import 'package:evrak/services/template_engine.dart';

final _placeholderPattern = RegExp(r'\{\{\s*([\w.]+)\s*\}\}');

void main() {
  test('9. Sınıf Matematik yıllık plan şablonu aktif ve dolu', () {
    expect(yillikPlan9MatematikTemplate.isActive, isTrue);
    expect(yillikPlan9MatematikTemplate.bodyText, isNotEmpty);
    expect(
      evrakCategories.any((c) => c.name == yillikPlan9MatematikTemplate.categoryId),
      isTrue,
    );
  });

  test('gövdedeki her {{alan}} required/optional listesinde bildirilmiş', () {
    final placeholders = _placeholderPattern
        .allMatches(yillikPlan9MatematikTemplate.bodyText)
        .map((m) => m.group(1)!)
        .toSet();
    final declared = {
      ...yillikPlan9MatematikTemplate.requiredFields,
      ...yillikPlan9MatematikTemplate.optionalFields,
    };
    for (final p in placeholders) {
      expect(declared.contains(p), isTrue, reason: '{{$p}} bildirilmemiş');
    }
  });

  test('şablon eksiksiz render edilir ve tüm 36 haftayı içerir', () {
    final data = <String, String>{
      for (final f in [...yillikPlan9MatematikTemplate.requiredFields, ...yillikPlan9MatematikTemplate.optionalFields])
        f: 'x',
    };
    final result = TemplateEngine.render(yillikPlan9MatematikTemplate, data);
    expect(result.isComplete, isTrue);
    expect(result.text.contains('{{'), isFalse);

    for (var i = 1; i <= 36; i++) {
      expect(result.text.contains('$i. Hafta'), isTrue, reason: '$i. Hafta metinde yok');
    }
    expect(result.text.contains('ARA TATİL'), isTrue);
    expect(result.text.contains('SÖMESTR'), isTrue);
  });
}
