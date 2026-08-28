import '../models/document_template.dart';

/// The first end-to-end pilot template, wired to the real generation
/// pipeline (profile autofill -> missing-field form -> PDF).
///
/// EVRAK_CLAUDE_CODE_CONTEXT.md §13 calls for validating the whole system
/// with a single template before the full ~50-document catalog is added.
const pilotAssignmentRequestTemplate = DocumentTemplate(
  id: 'assignment_request_001',
  title: 'Görevlendirme Talep Dilekçesi',
  slug: 'gorevlendirme-talep-dilekcesi',
  categoryName: 'Atama İşlemleri',
  description: 'Görevlendirme talebi için kişiselleştirilebilir dilekçe.',
  bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} İlçe Millî Eğitim Müdürlüğü
{{school.name}} Müdürlüğüne

Konu: {{document.subject}}

Okulunuzda {{teacher.branch}} öğretmeni olarak görev yapmaktayım.

Gereğini arz ederim.

Tarih: {{document.date}}

Ad Soyad: {{teacher.fullName}}
Sicil No: {{teacher.registrationNo}}
Telefon: {{teacher.phone}}
İmza:''',
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'school.city',
    'school.district',
    'document.date',
    'document.subject',
  ],
  optionalFields: [
    'teacher.registrationNo',
    'teacher.phone',
  ],
  tags: ['görevlendirme', 'atama', 'dilekçe'],
  status: TemplateStatus.verified,
);
