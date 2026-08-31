import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/featured_templates.dart';
import 'package:evrak/data/imported_templates.dart';
import 'package:evrak/data/imported_templates_batch2.dart';
import 'package:evrak/data/pilot_templates.dart';
import 'package:evrak/models/document.dart';
import 'package:evrak/services/template_engine.dart';

final _placeholderPattern = RegExp(r'\{\{\s*([\w.]+)\s*\}\}');

void main() {
  test('imported batch 2 has 21 unique, active, built entries', () {
    expect(importedTemplatesBatch2.length, 21);

    final ids = importedTemplatesBatch2.map((t) => t.id).toSet();
    expect(ids.length, 21, reason: 'template ids must be unique');

    for (final template in importedTemplatesBatch2) {
      expect(template.isActive, isTrue, reason: '${template.id} is imported and must be active');
      expect(template.bodyText, isNotEmpty, reason: '${template.id} must have real body text');
      expect(
        evrakCategories.any((c) => c.name == template.categoryId),
        isTrue,
        reason: '${template.id} categoryId "${template.categoryId}" must be a known category',
      );
    }
  });

  test('batch 2 ids do not collide with any other active template list', () {
    final allIds = [
      pilotAssignmentRequestTemplate.id,
      ...featuredTemplates.map((t) => t.id),
      ...importedTemplates.map((t) => t.id),
      ...importedTemplatesBatch2.map((t) => t.id),
    ];
    expect(allIds.toSet().length, allIds.length, reason: 'no id should appear in more than one active template list');
  });

  test('every placeholder used in a batch 2 template body is declared as a field', () {
    for (final template in importedTemplatesBatch2) {
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

  test('batch 2 templates render fully when all required fields are supplied', () {
    for (final template in importedTemplatesBatch2) {
      final data = <String, String>{
        for (final field in [...template.requiredFields, ...template.optionalFields]) field: 'x',
      };
      final result = TemplateEngine.render(template, data);
      expect(result.isComplete, isTrue, reason: '${template.id} should have no missing fields');
      expect(result.text.contains('{{'), isFalse, reason: '${template.id} left an unresolved placeholder');
    }
  });
}
