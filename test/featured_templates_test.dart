import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/featured_templates.dart';
import 'package:evrak/models/document.dart';
import 'package:evrak/services/template_engine.dart';

final _placeholderPattern = RegExp(r'\{\{\s*([\w.]+)\s*\}\}');

void main() {
  test('featured templates have 6 unique, active, built entries', () {
    expect(featuredTemplates.length, 6);

    final ids = featuredTemplates.map((t) => t.id).toSet();
    expect(ids.length, 6, reason: 'template ids must be unique');

    for (final template in featuredTemplates) {
      expect(template.isActive, isTrue, reason: '${template.id} is featured and must be active');
      expect(template.bodyText, isNotEmpty, reason: '${template.id} must have real body text');
      expect(
        evrakCategories.any((c) => c.name == template.categoryId),
        isTrue,
        reason: '${template.id} categoryId "${template.categoryId}" must be a known category',
      );
    }
  });

  test('every placeholder used in a featured template body is declared as a field', () {
    for (final template in featuredTemplates) {
      final placeholders = _placeholderPattern.allMatches(template.bodyText).map((m) => m.group(1)!).toSet();
      final declared = {...template.requiredFields, ...template.optionalFields};
      for (final placeholder in placeholders) {
        expect(
          declared.contains(placeholder),
          isTrue,
          reason: '${template.id} uses {{$placeholder}} but does not declare it as required/optional, '
              'so it would silently render blank',
        );
      }
    }
  });

  test('featured templates render fully when all required fields are supplied', () {
    for (final template in featuredTemplates) {
      final data = <String, String>{
        for (final field in [...template.requiredFields, ...template.optionalFields]) field: 'x',
      };
      final result = TemplateEngine.render(template, data);
      expect(result.isComplete, isTrue, reason: '${template.id} should have no missing fields');
      expect(result.text.contains('{{'), isFalse, reason: '${template.id} left an unresolved placeholder');
    }
  });
}
