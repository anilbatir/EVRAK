import '../models/document_template.dart';

/// Templates that are actually wired to the real generation pipeline
/// (profile autofill -> missing-field form -> PDF), as opposed to the
/// metadata-only entries in `catalogSeed`.
///
/// Metadata here is kept in sync with the official catalog record for
/// the same id in docs/catalog/evrak_document_templates_seed_v1.json;
/// `description`, `bodyText` and `tags` are EVRAK's own additions on
/// top of that shared schema.
///
/// docs/catalog/EVRAK_ILK_50_BELGE_KATALOGU_V1.md calls for validating
/// the whole system with one `custom_template` and one `official_form`
/// before expanding the catalog. This is the `custom_template` pilot
/// (id ATG-001); the `official_form` pilot will follow once a real
/// official-form DOCX/PDF reference is available to build it from.
///
/// Body text and field set updated to the version the user's ChatGPT
/// workflow produced (Google Drive "EVRAK" folder) - more specific about
/// the assignment request itself (reason/place/date range) than the
/// original placeholder draft.
const pilotAssignmentRequestTemplate = DocumentTemplate(
  id: 'ATG-001',
  title: 'Görevlendirme Talep Dilekçesi',
  categoryId: 'Atama ve Görevlendirme',
  sourceStatus: SourceStatus.customTemplate,
  sensitivity: Sensitivity.medium,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'school.city',
    'school.district',
    'request.assignmentReason',
    'request.assignmentPlace',
    'request.startDate',
    'request.endDate',
    'document.date',
  ],
  optionalFields: [
    'request.notes',
  ],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Görevlendirme talebi için kişiselleştirilebilir şablon (örnek/kişiselleştirilebilir belge - resmi standart form değildir).',
  bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Görevlendirme Talebi

Kurumunuzda {{teacher.branch}} öğretmeni olarak görev yapmaktayım. {{request.assignmentReason}} nedeniyle {{request.assignmentPlace}} kurumunda/alanında {{request.startDate}} - {{request.endDate}} tarihleri arasında görevlendirilmem hususunda gereğini arz ederim.

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:

Ek/Açıklama: {{request.notes}}''',
  tags: ['görevlendirme', 'atama', 'dilekçe'],
);
