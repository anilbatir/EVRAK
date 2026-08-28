enum TemplateStatus { draft, review, verified, deprecated }

class DocumentTemplate {
  final String id;
  final String title;
  final String slug;
  final String categoryName;
  final String description;
  final String bodyText;
  final List<String> requiredFields;
  final List<String> optionalFields;
  final List<String> tags;
  final TemplateStatus status;
  final bool isActive;
  final int version;

  const DocumentTemplate({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryName,
    required this.description,
    required this.bodyText,
    this.requiredFields = const [],
    this.optionalFields = const [],
    this.tags = const [],
    this.status = TemplateStatus.draft,
    this.isActive = true,
    this.version = 1,
  });

  bool get isVerified => status == TemplateStatus.verified;
}
