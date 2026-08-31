import '../models/document_template.dart';

/// Templates wired to the real generation pipeline (profile autofill ->
/// missing-field form -> PDF), same as `pilotAssignmentRequestTemplate` in
/// pilot_templates.dart. These are the four documents featured on the home
/// screen's "Sık Kullanılanlar" row.
///
/// Ids match the corresponding metadata-only records in catalog_seed.dart /
/// extended_catalog_seed.dart (PLN-001, PLN-002, KZM-001..003) - those files
/// stay untouched (they mirror the official catalog); these are the
/// "activated" copies with real body text, same convention as ATG-001.
///
/// For Yıllık Plan, Günlük Plan and Kazanımlar, EVRAK does not generate the
/// actual curriculum content (topics/kazanım codes) - that comes from MEB's
/// own curriculum and varies per subject/grade. These templates prepare the
/// official administrative wrapper (okul/öğretmen bilgisi, onay/imza bloğu)
/// around a free-text field the teacher fills with their own content.
const yillikPlanTemplate = DocumentTemplate(
  id: 'PLN-001',
  title: 'Yıllık Plan',
  categoryId: 'Planlar',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'lesson.subject',
    'lesson.gradeLevel',
    'document.startDate',
    'document.endDate',
    'plan.content',
  ],
  optionalFields: ['school.principalName'],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Ders yılı boyunca izlenecek konu ve kazanımların okul/öğretmen bilgileriyle hazırlanan resmi kapak ve onay sayfası.',
  bodyText: '''T.C.
{{school.name}}
{{document.startDate}} - {{document.endDate}} Eğitim Öğretim Yılı
{{lesson.subject}} Dersi Yıllık Planı

Sınıf/Şube: {{lesson.gradeLevel}}
Hazırlayan Öğretmen: {{teacher.fullName}} ({{teacher.branch}})

Planın Kapsamı (Konular ve Kazanımlar):
{{plan.content}}

Bu plan, ilgili dersin yıllık müfredatı ve okul takvimi doğrultusunda hazırlanmıştır.

Öğretmen: {{teacher.fullName}}
İmza:

Onaylayan: {{school.principalName}}
İmza:''',
  tags: ['yıllık plan', 'planlar'],
);

const gunlukPlanTemplate = DocumentTemplate(
  id: 'PLN-002',
  title: 'Günlük Plan',
  categoryId: 'Planlar',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'lesson.subject',
    'lesson.gradeLevel',
    'lesson.topic',
    'document.date',
    'plan.content',
  ],
  optionalFields: [],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Tek bir ders saati için hazırlanan, konu ve kazanımların işlendiği günlük ders planı.',
  bodyText: '''T.C.
{{school.name}}
Günlük Ders Planı

Tarih: {{document.date}}
Ders: {{lesson.subject}}
Sınıf/Şube: {{lesson.gradeLevel}}
Konu: {{lesson.topic}}
Öğretmen: {{teacher.fullName}} ({{teacher.branch}})

Kazanımlar ve Etkinlikler:
{{plan.content}}

Öğretmen İmzası: {{teacher.fullName}}''',
  tags: ['günlük plan', 'planlar'],
);

const kazanimlarTemplate = DocumentTemplate(
  id: 'KZN-001',
  title: 'Kazanımlar',
  categoryId: 'Planlar',
  sourceStatus: SourceStatus.customTemplate,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'lesson.subject',
    'document.startDate',
    'document.endDate',
    'plan.content',
  ],
  optionalFields: [],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Haftalık olarak hangi derste hangi konu/kazanımın işlendiğini özetleyen, sınıf defterine işlemek için kullanılan kısa çizelge (günlük planın özet halidir).',
  bodyText: '''T.C.
{{school.name}}
Haftalık Kazanımlar Çizelgesi

Tarih Aralığı: {{document.startDate}} - {{document.endDate}}
Ders: {{lesson.subject}}
Öğretmen: {{teacher.fullName}} ({{teacher.branch}})

Bu hafta işlenen konu ve kazanımlar (sınıf defterine işlenmek üzere):
{{plan.content}}

Öğretmen İmzası: {{teacher.fullName}}''',
  tags: ['kazanım', 'haftalık', 'sınıf defteri'],
);

const zumreSeneBasiTemplate = DocumentTemplate(
  id: 'KZM-001',
  title: 'Sene Başı Zümre Öğretmenler Kurulu Toplantı Tutanağı',
  categoryId: 'Kurul ve Zümre',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'school.city',
    'school.district',
    'academic.year',
    'meeting.date',
    'meeting.time',
    'meeting.location',
  ],
  optionalFields: ['zumreMembers', 'agendaItems', 'decisions'],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Eğitim öğretim yılı başında yapılan zümre öğretmenler kurulu toplantısının tutanağı.',
  bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}}

{{teacher.branch}} ZÜMRE ÖĞRETMENLER KURULU TOPLANTI TUTANAĞI

Toplantı Tarihi: {{meeting.date}}
Toplantı Saati: {{meeting.time}}
Toplantı Yeri: {{meeting.location}}
Eğitim Öğretim Yılı: {{academic.year}}
Zümre Başkanı: {{teacher.fullName}}

Katılımcılar (Ad Soyad - Branş, her satıra bir kişi):
{{zumreMembers}}

Gündem Maddeleri:
{{agendaItems}}

Görüşülen Konular ve Alınan Kararlar:
{{decisions}}''',
  tags: ['zümre', 'tutanak', 'sene başı'],
);

const zumreAraDonemTemplate = DocumentTemplate(
  id: 'KZM-002',
  title: 'Ara Dönem Zümre Toplantı Tutanağı',
  categoryId: 'Kurul ve Zümre',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'academic.year',
    'meeting.date',
    'meeting.time',
    'meeting.location',
  ],
  optionalFields: ['zumreMembers', 'agendaItems', 'decisions'],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Dönem ortasında yapılan zümre toplantısının tutanağı.',
  bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{teacher.branch}} ARA DÖNEM ZÜMRE TOPLANTI TUTANAĞI

Toplantı Tarihi: {{meeting.date}}
Toplantı Saati: {{meeting.time}}
Toplantı Yeri: {{meeting.location}}
Zümre Başkanı: {{teacher.fullName}}

Katılımcılar (Ad Soyad - Branş, her satıra bir kişi):
{{zumreMembers}}

Gündem:
{{agendaItems}}

Kararlar:
{{decisions}}''',
  tags: ['zümre', 'tutanak', 'ara dönem'],
);

const zumreSeneSonuTemplate = DocumentTemplate(
  id: 'KZM-003',
  title: 'Sene Sonu Zümre Öğretmenler Kurulu Toplantı Tutanağı',
  categoryId: 'Kurul ve Zümre',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
    'academic.year',
    'meeting.date',
    'meeting.time',
    'meeting.location',
  ],
  optionalFields: ['zumreMembers', 'agendaItems', 'decisions'],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: 'Eğitim öğretim yılı sonunda yapılan zümre öğretmenler kurulu toplantısının tutanağı.',
  bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{teacher.branch}} SENE SONU ZÜMRE ÖĞRETMENLER KURULU TOPLANTI TUTANAĞI

Toplantı Tarihi: {{meeting.date}}
Toplantı Saati: {{meeting.time}}
Toplantı Yeri: {{meeting.location}}
Zümre Başkanı: {{teacher.fullName}}

Katılımcılar (Ad Soyad - Branş, her satıra bir kişi):
{{zumreMembers}}

Yıl Sonu Değerlendirme Başlıkları:
{{agendaItems}}

Alınan Kararlar / Sonraki Yıla Öneriler:
{{decisions}}''',
  tags: ['zümre', 'tutanak', 'sene sonu'],
);

/// All templates wired to real generation, keyed by nothing in particular -
/// just the flat list category_documents_screen.dart filters and searches.
const List<DocumentTemplate> featuredTemplates = [
  yillikPlanTemplate,
  gunlukPlanTemplate,
  kazanimlarTemplate,
  zumreSeneBasiTemplate,
  zumreAraDonemTemplate,
  zumreSeneSonuTemplate,
];
