import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/pilot_templates.dart';
import 'package:evrak/models/document_template.dart';
import 'package:evrak/services/template_engine.dart';

void main() {
  group('TemplateEngine', () {
    test('reports missing required fields', () {
      final missing = TemplateEngine.missingRequiredFields(
        pilotAssignmentRequestTemplate,
        {'teacher.fullName': 'Ayşe Yılmaz'},
      );

      expect(missing, containsAll(['teacher.branch', 'school.name']));
      expect(missing, isNot(contains('teacher.fullName')));
    });

    test('renders placeholders and reports completeness', () {
      const template = DocumentTemplate(
        id: 't1',
        title: 'Test',
        categoryId: 'Test',
        sourceStatus: SourceStatus.customTemplate,
        sensitivity: Sensitivity.low,
        bodyText: 'Merhaba {{teacher.fullName}}, okulun {{school.name}}.',
        requiredFields: ['teacher.fullName', 'school.name'],
      );

      final result = TemplateEngine.render(template, {
        'teacher.fullName': 'Ayşe Yılmaz',
        'school.name': 'Atatürk İlkokulu',
      });

      expect(result.text, 'Merhaba Ayşe Yılmaz, okulun Atatürk İlkokulu.');
      expect(result.isComplete, isTrue);
    });

    test('leaves unresolved placeholders blank and flags them as missing', () {
      const template = DocumentTemplate(
        id: 't2',
        title: 'Test',
        categoryId: 'Test',
        sourceStatus: SourceStatus.customTemplate,
        sensitivity: Sensitivity.low,
        bodyText: 'Sicil No: {{teacher.registrationNo}}',
        requiredFields: ['teacher.registrationNo'],
      );

      final result = TemplateEngine.render(template, {});

      expect(result.text, 'Sicil No: ');
      expect(result.isComplete, isFalse);
      expect(result.missingRequiredFields, ['teacher.registrationNo']);
    });
  });
}
