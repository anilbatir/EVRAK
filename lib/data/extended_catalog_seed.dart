import '../models/document_template.dart';

/// Metadata-only reference entries for the categories surfaced by the
/// "ÖğretmenEvrak" reference app's sidebar that were not already present
/// in the official 50-document catalog (docs/catalog/). Zümre
/// Tutanakları, Veli Toplantı Tutanakları and Rehberlik Raporları from
/// that sidebar were NOT duplicated here - they already exist in
/// catalog_seed.dart under Kurul ve Zümre / Veli İşlemleri / BEP ve
/// Rehberlik.
///
/// Like catalog_seed.dart, none of these have body text yet and none
/// are active - they are backlog, not wired to the generation pipeline.
final List<DocumentTemplate> extendedCatalogSeed = [
  const DocumentTemplate(
    id: 'MRF-001',
    title: 'Aylık Maarif Raporları',
    categoryId: 'Maarif Evrakları',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: ['teacher.fullName', 'school.name', 'document.date'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'MRF-002',
    title: 'Okul Temelli Planlama',
    categoryId: 'Maarif Evrakları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'document.startDate', 'document.endDate'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'MRF-003',
    title: 'Sosyal Etkinlikler',
    categoryId: 'Maarif Evrakları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'document.date', 'document.description'],
    optionalFields: ['teacher.fullName'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'PLN-001',
    title: 'Yıllık Plan',
    categoryId: 'Planlar',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.low,
    requiredFields: ['teacher.fullName', 'teacher.branch', 'document.startDate', 'document.endDate'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'PLN-002',
    title: 'Günlük Plan',
    categoryId: 'Planlar',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.low,
    requiredFields: ['teacher.fullName', 'teacher.branch', 'document.date'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'PLN-003',
    title: 'İYEP (İlkokullarda Yetiştirme Programı)',
    categoryId: 'Planlar',
    sourceStatus: SourceStatus.officialForm,
    sensitivity: Sensitivity.medium,
    requiredFields: ['student.fullName', 'student.className', 'teacher.fullName', 'document.startDate', 'document.endDate'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'PLN-004',
    title: 'Egzersiz Planları',
    categoryId: 'Planlar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['teacher.fullName', 'student.className', 'document.date'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'EVK-001',
    title: 'Kulüp Evrakları',
    categoryId: 'Kulüp Evrakları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['teacher.fullName', 'school.name', 'document.date'],
    optionalFields: ['document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'EVK-002',
    title: 'Aday Öğretmenlik',
    categoryId: 'Aday Öğretmenlik',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: ['teacher.fullName', 'school.name', 'document.date'],
    optionalFields: ['teacher.registrationNo', 'document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
  const DocumentTemplate(
    id: 'EVK-003',
    title: 'Diğer Evraklar',
    categoryId: 'Diğer Evraklar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['teacher.fullName', 'school.name', 'document.date', 'document.description'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.draft,
  ),
];
