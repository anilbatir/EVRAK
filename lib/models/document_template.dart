/// Mirrors the `documentTemplates` Firestore schema defined in
/// docs/catalog/EVRAK_ILK_50_BELGE_KATALOGU_V1.md.
library;

enum SourceStatus {
  /// A real MEB (or affiliated official body) form/example exists;
  /// production content must be based on that official example.
  officialForm,

  /// An official guideline covers this document type/structure, but it
  /// may need institution/level-specific adaptation.
  officialBasis,

  /// A convenience template EVRAK prepares for a commonly-needed
  /// document; must not be presented as an official standard form.
  customTemplate;

  String get jsonValue {
    switch (this) {
      case SourceStatus.officialForm:
        return 'official_form';
      case SourceStatus.officialBasis:
        return 'official_basis';
      case SourceStatus.customTemplate:
        return 'custom_template';
    }
  }

  static SourceStatus fromJson(String value) {
    switch (value) {
      case 'official_form':
        return SourceStatus.officialForm;
      case 'official_basis':
        return SourceStatus.officialBasis;
      case 'custom_template':
        return SourceStatus.customTemplate;
      default:
        throw ArgumentError('Unknown sourceStatus: $value');
    }
  }
}

enum Sensitivity {
  low,
  medium,
  high;

  static Sensitivity fromJson(String value) => Sensitivity.values.firstWhere(
        (s) => s.name == value,
        orElse: () => Sensitivity.medium,
      );
}

enum LifecycleStatus {
  draft,
  review,
  verified,
  deprecated;

  static LifecycleStatus fromJson(String value) => LifecycleStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => LifecycleStatus.draft,
      );
}

class DocumentTemplate {
  final String id;
  final String title;
  final String categoryId;
  final SourceStatus sourceStatus;
  final Sensitivity sensitivity;
  final List<String> requiredFields;
  final List<String> optionalFields;
  final List<String> outputFormats;
  final int version;
  final LifecycleStatus lifecycleStatus;
  final bool isActive;

  /// Not part of the shared catalog schema; populated only for templates
  /// EVRAK has actually built out (description shown in the UI).
  final String description;

  /// The `{{path.to.field}}` template body. Empty for catalog entries
  /// that are metadata-only placeholders (not yet wired to generation).
  final String bodyText;

  final List<String> tags;

  const DocumentTemplate({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.sourceStatus,
    required this.sensitivity,
    this.requiredFields = const [],
    this.optionalFields = const [],
    this.outputFormats = const ['pdf'],
    this.version = 1,
    this.lifecycleStatus = LifecycleStatus.draft,
    this.isActive = false,
    this.description = '',
    this.bodyText = '',
    this.tags = const [],
  });

  bool get isVerified => lifecycleStatus == LifecycleStatus.verified;

  /// Whether this template is actually wired to the generation pipeline
  /// (has real body text to render), as opposed to being a catalog
  /// placeholder awaiting a real DOCX/PDF template.
  bool get isBuilt => bodyText.isNotEmpty;
}
