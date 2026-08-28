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
    'document.date',
  ],
  optionalFields: [
    'teacher.registrationNo',
    'teacher.phone',
    'document.description',
  ],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Görevlendirme talebi için kişiselleştirilebilir şablon (örnek/kişiselleştirilebilir belge - resmi standart form değildir).',
  bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} İlçe Millî Eğitim Müdürlüğü
{{school.name}} Müdürlüğüne

{{teacher.fullName}}, okulunuzda {{teacher.branch}} öğretmeni olarak görev yapmaktayım.

{{document.description}}

Gereğini arz ederim.

Tarih: {{document.date}}

Ad Soyad: {{teacher.fullName}}
Sicil No: {{teacher.registrationNo}}
Telefon: {{teacher.phone}}
İmza:''',
  tags: ['görevlendirme', 'atama', 'dilekçe'],
);
