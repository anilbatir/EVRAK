import '../models/document_template.dart';

class TemplateRenderResult {
  final String text;
  final List<String> missingRequiredFields;

  const TemplateRenderResult({required this.text, required this.missingRequiredFields});

  bool get isComplete => missingRequiredFields.isEmpty;
}

/// Fills a template's `{{path.to.field}}` placeholders using a flat
/// `"path.to.field" -> value` data map, and reports which of the
/// template's declared required fields were not present in the data.
class TemplateEngine {
  static final RegExp _placeholderPattern = RegExp(r'\{\{\s*([\w.]+)\s*\}\}');

  static List<String> missingRequiredFields(
    DocumentTemplate template,
    Map<String, String> data,
  ) {
    return template.requiredFields
        .where((field) => (data[field] ?? '').trim().isEmpty)
        .toList();
  }

  static TemplateRenderResult render(
    DocumentTemplate template,
    Map<String, String> data,
  ) {
    final missing = missingRequiredFields(template, data);
    final rendered = template.bodyText.replaceAllMapped(_placeholderPattern, (match) {
      final key = match.group(1)!;
      return data[key] ?? '';
    });
    return TemplateRenderResult(text: rendered, missingRequiredFields: missing);
  }
}
