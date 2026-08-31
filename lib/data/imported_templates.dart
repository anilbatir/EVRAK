import '../models/document_template.dart';

/// Templates written from the official 50-document catalog by the user's
/// ChatGPT workflow (Google Drive "EVRAK" folder), reviewed and adapted
/// here to EVRAK's actual template engine.
///
/// The Drive originals use Mustache-style repeating sections
/// (`{{#listName}}...{{/listName}}`) for tables/lists (katılımcılar,
/// gündem maddeleri, kararlar, vb.). EVRAK's `TemplateEngine` only does
/// flat `{{path.to.field}}` substitution - no loops. Rather than build a
/// list-editing UI for ~15 different repeating sections, every such block
/// was flattened to a single free-text field carrying the same name as the
/// original list (e.g. `{{#decisions}}...{{/decisions}}` -> one
/// `{{decisions}}` field the teacher fills in as plain lines), matching
/// the approach already used for Yıllık Plan / Günlük Plan / Kazanımlar.
///
/// ATG-001 and KZM-001/002/003 already existed with different field sets
/// (pilot_templates.dart, featured_templates.dart); those were left as-is
/// there rather than duplicated here. Two accidental duplicate exports in
/// the Drive folder (a second KZM-001 folder, a second SNV-002 folder)
/// were not imported.
const List<DocumentTemplate> importedTemplates = [
  // ---- İzin İşlemleri ----
  DocumentTemplate(
    id: 'IZN-001',
    title: 'Mazeret İzni Talep Dilekçesi',
    categoryId: 'İzin İşlemleri',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'leave.reason', 'leave.startDate', 'leave.endDate', 'leave.dayCount', 'document.date',
    ],
    optionalFields: ['teacher.phone', 'leave.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Mazeret izni talebinde bulunmak için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Mazeret İzni Talebi

{{leave.reason}} nedeniyle {{leave.startDate}} tarihinde başlayıp {{leave.endDate}} tarihinde sona ermek üzere toplam {{leave.dayCount}} gün mazeret izni kullanmak istiyorum. Gereğini arz ederim.

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:

İletişim: {{teacher.phone}}
Açıklama/Ek: {{leave.notes}}''',
    tags: ['izin', 'mazeret', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'IZN-002',
    title: 'Yıllık İzin Talep Dilekçesi',
    categoryId: 'İzin İşlemleri',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'leave.startDate', 'leave.endDate', 'leave.dayCount', 'document.date',
    ],
    optionalFields: ['leave.address', 'teacher.phone'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Yıllık izin talebinde bulunmak için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Yıllık İzin Talebi

{{leave.startDate}} - {{leave.endDate}} tarihleri arasında toplam {{leave.dayCount}} gün yıllık izin kullanmak istiyorum. İzin süresince iletişim bilgilerim aşağıdadır. Gereğini arz ederim.

İzin adresi: {{leave.address}}
Telefon: {{teacher.phone}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['izin', 'yıllık izin', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'IZN-003',
    title: 'Ücretsiz İzin Talep Dilekçesi',
    categoryId: 'İzin İşlemleri',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'leave.reason', 'leave.startDate', 'leave.endDate', 'document.date',
    ],
    optionalFields: ['leave.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Aylıksız/ücretsiz izin talebinde bulunmak için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Aylıksız / Ücretsiz İzin Talebi

{{leave.reason}} nedeniyle {{leave.startDate}} tarihinden {{leave.endDate}} tarihine kadar aylıksız/ücretsiz izin kullanmak istiyorum. Talebimin ilgili mevzuat ve yetkili makam değerlendirmesi çerçevesinde işleme alınmasını arz ederim.

Açıklama: {{leave.notes}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['izin', 'ücretsiz izin', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'IZN-004',
    title: 'Doğum Sonrası İzin Talep Dilekçesi',
    categoryId: 'İzin İşlemleri',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'leave.startDate', 'leave.endDate', 'document.date',
    ],
    optionalFields: ['leave.attachments'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Doğum sonrası izin hakkını kullanmak için başvuru dilekçesi.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Doğum Sonrası İzin Talebi

Doğum sonrası izin hakkım kapsamında {{leave.startDate}} - {{leave.endDate}} tarihleri arasında izin kullanmak istiyorum. İlgili belgeler ektedir. Gereğini arz ederim.

Ekler: {{leave.attachments}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['izin', 'doğum izni', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'IZN-005',
    title: 'Süt İzni Tercih Dilekçesi',
    categoryId: 'İzin İşlemleri',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'leave.startDate', 'leave.dailyTimeRange', 'document.date',
    ],
    optionalFields: ['leave.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Süt izni saatlerini tercih etmek için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Süt İzni Kullanım Tercihi

Süt izni hakkımı {{leave.startDate}} tarihinden itibaren aşağıdaki saat aralığında kullanmak istiyorum. Tercihimin görev ve ders programım dikkate alınarak değerlendirilmesini arz ederim.

Tercih edilen saat aralığı: {{leave.dailyTimeRange}}
Açıklama: {{leave.notes}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['izin', 'süt izni', 'dilekçe'],
  ),

  // ---- Maaş ve Ek Ders ----
  DocumentTemplate(
    id: 'MED-001',
    title: 'Ek Ders Çizelgesi Kişisel Kontrol Formu',
    categoryId: 'Maaş ve Ek Ders',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'teacher.branch', 'school.name', 'academic.year',
      'payroll.monthYear', 'payroll.totalExtraHours', 'document.date',
    ],
    optionalFields: [
      'payroll.weeklyLessonHours', 'payroll.dutyHours', 'payroll.otherHours',
      'payroll.entries', 'payroll.notes',
    ],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Aylık ek ders çizelgesini öğretmenin kendi kaydıyla karşılaştırmak için kullanılan kontrol formu.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

EK DERS ÇİZELGESİ KİŞİSEL KONTROL FORMU

Öğretmen: {{teacher.fullName}}
Branş: {{teacher.branch}}
Ay / Yıl: {{payroll.monthYear}}
Haftalık Ders Saati: {{payroll.weeklyLessonHours}}
Toplam Ek Ders Saati: {{payroll.totalExtraHours}}
Nöbet Saati: {{payroll.dutyHours}}
Diğer: {{payroll.otherHours}}

Haftalık / Günlük Dağılım (tarih - tür - saat - açıklama, her satıra bir kayıt):
{{payroll.entries}}

Kontrol Notu:
{{payroll.notes}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['ek ders', 'maaş', 'kontrol formu'],
  ),
  DocumentTemplate(
    id: 'MED-002',
    title: 'Eksik Ek Ders Ödemesi Düzeltme Dilekçesi',
    categoryId: 'Maaş ve Ek Ders',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'document.date', 'payroll.monthYear', 'payroll.missingHours',
    ],
    optionalFields: ['teacher.branch', 'teacher.registrationNo', 'payroll.notes', 'payroll.attachments'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Ek ders ödemesindeki eksikliğin düzeltilmesini talep etmek için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Eksik Ek Ders Ödemesi Hakkında

{{payroll.monthYear}} dönemine ait ek ders ödememde {{payroll.missingHours}} saat eksiklik bulunduğunu değerlendirmekteyim. İlgili ders programı ve görev bilgilerimin incelenerek gerekli düzeltmenin yapılmasını arz ederim.

Eksiklik açıklaması: {{payroll.notes}}
Ekler: {{payroll.attachments}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
Branş: {{teacher.branch}}
Sicil No: {{teacher.registrationNo}}
İmza:''',
    tags: ['ek ders', 'maaş', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'MED-003',
    title: 'Banka / Maaş Bilgisi Güncelleme Dilekçesi',
    categoryId: 'Maaş ve Ek Ders',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district',
      'document.date', 'bank.name', 'bank.iban',
    ],
    optionalFields: ['teacher.registrationNo'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Maaş ödemesinde kullanılan banka bilgilerini güncellemek için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Banka / Maaş Bilgisi Güncelleme Talebi

Maaş ve diğer özlük ödemelerimde kullanılmak üzere banka bilgilerimin aşağıdaki şekilde güncellenmesini arz ederim.

Banka: {{bank.name}}
IBAN: {{bank.iban}}
Hesap Sahibi: {{teacher.fullName}}
Sicil No: {{teacher.registrationNo}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['maaş', 'banka', 'dilekçe'],
  ),

  // ---- Kurul ve Zümre (ek, KZM-001/002/003 zaten featured_templates.dart'ta) ----
  DocumentTemplate(
    id: 'KZM-004',
    title: 'Şube Öğretmenler Kurulu Toplantı Tutanağı',
    categoryId: 'Kurul ve Zümre',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'school.name', 'academic.year', 'classroom.name', 'meeting.date',
      'meeting.time', 'meeting.location', 'teacher.fullName',
    ],
    optionalFields: ['branchTeachers', 'agendaItems', 'studentNotes', 'decisions'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir şubenin ders veren öğretmenlerinin katıldığı kurul toplantısının tutanağı.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{classroom.name}} ŞUBE ÖĞRETMENLER KURULU TOPLANTI TUTANAĞI

Tarih: {{meeting.date}}
Saat: {{meeting.time}}
Yer: {{meeting.location}}
Şube: {{classroom.name}}
Başkan: {{teacher.fullName}}

Katılımcı Öğretmenler (Ad Soyad - Branş, her satıra bir kişi):
{{branchTeachers}}

Gündem:
{{agendaItems}}

Öğrenci / Sınıf Değerlendirmeleri:
{{studentNotes}}

Kararlar:
{{decisions}}''',
    tags: ['zümre', 'kurul', 'tutanak'],
  ),
  DocumentTemplate(
    id: 'KZM-005',
    title: 'Öğretmenler Kurulu Karar Takip Formu',
    categoryId: 'Kurul ve Zümre',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'meeting.date', 'meeting.period'],
    optionalFields: ['school.principalName', 'decisionTracking'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Öğretmenler kurulunda alınan kararların takibi için kullanılan tablo.',
    bodyText: '''{{school.name}}

ÖĞRETMENLER KURULU KARAR TAKİP FORMU

Toplantı Tarihi: {{meeting.date}}
Toplantı Dönemi: {{meeting.period}}
Sorumlu Yönetici: {{school.principalName}}

Kararlar (No - Karar - Sorumlu - Termin - Durum, her satıra bir kayıt):
{{decisionTracking}}''',
    tags: ['kurul', 'karar takip', 'form'],
  ),

  // ---- Veli İşlemleri ----
  DocumentTemplate(
    id: 'VEL-001',
    title: 'Veli Görüşme Formu',
    categoryId: 'Veli İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className', 'parent.fullName',
      'meeting.date', 'teacher.fullName', 'teacher.branch', 'meeting.topic',
    ],
    optionalFields: ['parent.phone', 'meeting.method', 'meeting.notes', 'meeting.followUp'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrencinin velisiyle yapılan görüşmenin kaydı.',
    bodyText: '''{{school.name}}

VELİ GÖRÜŞME FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Veli: {{parent.fullName}}
Veli Telefon: {{parent.phone}}
Görüşme Tarihi: {{meeting.date}}
Görüşme Şekli: {{meeting.method}}
Görüşmeyi Yapan Öğretmen: {{teacher.fullName}}
Branş: {{teacher.branch}}

Görüşme Konusu:
{{meeting.topic}}

Görüşme Notları:
{{meeting.notes}}

Alınan Kararlar / Takip:
{{meeting.followUp}}

Öğretmen İmza:                                Veli İmza:''',
    tags: ['veli', 'görüşme', 'form'],
  ),
  DocumentTemplate(
    id: 'VEL-002',
    title: 'Veli Toplantısı Davet Yazısı',
    categoryId: 'Veli İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: [
      'school.name', 'parent.fullName', 'student.className', 'meeting.date',
      'meeting.time', 'meeting.location', 'meeting.topic', 'teacher.fullName',
    ],
    optionalFields: ['meeting.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Veli toplantısına davet için gönderilen yazı.',
    bodyText: '''{{school.name}}

VELİ TOPLANTISI DAVETİ

Sayın {{parent.fullName}},

{{student.className}} sınıf/şubesi için düzenlenecek veli toplantımıza katılımınızı rica ederiz.

Tarih: {{meeting.date}}
Saat: {{meeting.time}}
Yer: {{meeting.location}}
Konu: {{meeting.topic}}

Sınıf/Şube Rehber Öğretmeni: {{teacher.fullName}}
İletişim / Not: {{meeting.notes}}''',
    tags: ['veli', 'toplantı', 'davet'],
  ),
  DocumentTemplate(
    id: 'VEL-003',
    title: 'Veli Toplantısı Tutanağı',
    categoryId: 'Veli İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'academic.year', 'student.className', 'meeting.date',
      'meeting.time', 'meeting.location', 'teacher.fullName',
    ],
    optionalFields: ['agendaItems', 'decisions', 'parentAttendees'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınıf/şube veli toplantısının tutanağı.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{student.className}} VELİ TOPLANTISI TUTANAĞI

Tarih: {{meeting.date}}
Saat: {{meeting.time}}
Yer: {{meeting.location}}
Toplantıyı Yürüten: {{teacher.fullName}}

Gündem:
{{agendaItems}}

Görüşülen Konular ve Kararlar:
{{decisions}}

Katılan Veliler (her satıra bir isim):
{{parentAttendees}}''',
    tags: ['veli', 'toplantı', 'tutanak'],
  ),
  DocumentTemplate(
    id: 'VEL-004',
    title: 'Veli İzin / Onay Formu',
    categoryId: 'Veli İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className', 'activity.name',
      'activity.date', 'activity.location', 'parent.fullName', 'document.date',
    ],
    optionalFields: ['parent.phone', 'activity.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir etkinlik/geziye katılım için veliden onay almak amacıyla kullanılan form.',
    bodyText: '''{{school.name}}

VELİ İZİN / ONAY FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}

{{activity.name}} etkinliği kapsamında {{activity.date}} tarihinde {{activity.location}} adresinde gerçekleştirilecek faaliyete öğrencimin katılmasına ilişkin tercihimi aşağıda bildiriyorum.

☐ Onaylıyorum ☐ Onaylamıyorum

Açıklama / Özel durum: {{activity.notes}}

Veli Ad Soyad: {{parent.fullName}}
Telefon: {{parent.phone}}
Tarih: {{document.date}}
İmza:''',
    tags: ['veli', 'izin', 'onay formu'],
  ),
  DocumentTemplate(
    id: 'VEL-005',
    title: 'Veli Bilgilendirme Tutanağı',
    categoryId: 'Veli İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className', 'parent.fullName',
      'teacher.fullName', 'meeting.date', 'meeting.topic', 'meeting.notes',
    ],
    optionalFields: ['meeting.followUp'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Veliye yapılan bilgilendirmenin kayıt altına alındığı tutanak.',
    bodyText: '''{{school.name}}

VELİ BİLGİLENDİRME TUTANAĞI

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Veli: {{parent.fullName}}
Öğretmen: {{teacher.fullName}}
Tarih: {{meeting.date}}
Konu: {{meeting.topic}}

Bilgilendirme İçeriği:
{{meeting.notes}}

Kararlaştırılan Takip / Aksiyon:
{{meeting.followUp}}

Öğretmen İmza:                                Veli İmza:''',
    tags: ['veli', 'bilgilendirme', 'tutanak'],
  ),

  // ---- BEP ve Rehberlik ----
  DocumentTemplate(
    id: 'BEP-001',
    title: 'Bireyselleştirilmiş Eğitim Programı (BEP) Formu',
    categoryId: 'BEP ve Rehberlik',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className', 'academic.year',
      'bep.course', 'teacher.fullName', 'document.startDate', 'document.endDate',
      'bep.currentPerformance', 'bep.methodsAndAssessment',
    ],
    optionalFields: ['bep.longTermGoals', 'bep.shortTermGoals', 'bep.teamMembers'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'EVRAK tarafından hazırlanan kişiselleştirilebilir BEP çalışma şablonudur; kurumun/resmî birimin güncel formu varsa onunla karşılaştırılarak kullanılmalıdır.',
    bodyText: '''{{school.name}}

BİREYSELLEŞTİRİLMİŞ EĞİTİM PROGRAMI (BEP) - ÇALIŞMA ŞABLONU

Bu belge EVRAK tarafından kişiselleştirilebilir çalışma şablonu olarak hazırlanmıştır; kurumun/resmî birimin güncel formu varsa onunla karşılaştırılarak kullanılmalıdır.

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Eğitim Öğretim Yılı: {{academic.year}}
Ders / Alan: {{bep.course}}
Sorumlu Öğretmen: {{teacher.fullName}}
Uygulama Dönemi: {{document.startDate}} - {{document.endDate}}

Performans Düzeyi / Başlangıç Durumu:
{{bep.currentPerformance}}

Uzun Dönemli Amaçlar:
{{bep.longTermGoals}}

Kısa Dönemli Amaçlar ve Ölçütler:
{{bep.shortTermGoals}}

Yöntem / Materyal / Değerlendirme:
{{bep.methodsAndAssessment}}

BEP Geliştirme Birimi (Ad Soyad - Rol, her satıra bir kişi):
{{bep.teamMembers}}''',
    tags: ['bep', 'rehberlik', 'çalışma şablonu'],
  ),
  DocumentTemplate(
    id: 'BEP-002',
    title: 'BEP Geliştirme Birimi Toplantı Tutanağı',
    categoryId: 'BEP ve Rehberlik',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className',
      'meeting.date', 'meeting.time', 'meeting.location',
    ],
    optionalFields: ['bepMembers', 'agendaItems', 'meeting.notes', 'decisions'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'BEP geliştirme birimi toplantısının tutanağı.',
    bodyText: '''{{school.name}}

BEP GELİŞTİRME BİRİMİ TOPLANTI TUTANAĞI

Toplantı Tarihi: {{meeting.date}}
Saat: {{meeting.time}}
Yer: {{meeting.location}}
Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}

Katılımcılar (Ad Soyad - Rol, her satıra bir kişi):
{{bepMembers}}

Gündem Maddeleri:
{{agendaItems}}

Değerlendirmeler:
{{meeting.notes}}

Alınan Kararlar:
{{decisions}}''',
    tags: ['bep', 'toplantı', 'tutanak'],
  ),
  DocumentTemplate(
    id: 'BEP-003',
    title: 'Öğrenci Görüşme Formu',
    categoryId: 'BEP ve Rehberlik',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name', 'student.fullName', 'student.className', 'meeting.date',
      'teacher.fullName', 'teacher.branch', 'meeting.topic',
    ],
    optionalFields: ['meeting.studentStatement', 'meeting.teacherObservation', 'meeting.followUp'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Rehberlik kapsamında bir öğrenciyle yapılan görüşmenin kaydı.',
    bodyText: '''{{school.name}}

ÖĞRENCİ GÖRÜŞME FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Görüşme Tarihi: {{meeting.date}}
Görüşmeyi Yapan: {{teacher.fullName}}
Görevi / Branşı: {{teacher.branch}}

Görüşme Konusu:
{{meeting.topic}}

Öğrencinin İfadesi / Görüşü:
{{meeting.studentStatement}}

Öğretmen Gözlemi:
{{meeting.teacherObservation}}

Alınan Kararlar / Yönlendirme:
{{meeting.followUp}}

Öğrenci İmza:                                Öğretmen İmza:''',
    tags: ['rehberlik', 'öğrenci görüşme', 'form'],
  ),
  DocumentTemplate(
    id: 'BEP-004',
    title: 'Öğretmen ile Görüşme Formu',
    categoryId: 'BEP ve Rehberlik',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'school.name', 'meeting.teacherName', 'meeting.teacherBranch',
      'meeting.date', 'teacher.fullName', 'meeting.topic',
    ],
    optionalFields: ['meeting.notes', 'meeting.followUp'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Rehberlik biriminin bir öğretmenle yaptığı görüşmenin kaydı.',
    bodyText: '''{{school.name}}

ÖĞRETMEN İLE GÖRÜŞME FORMU

Görüşülen Öğretmen: {{meeting.teacherName}}
Branşı: {{meeting.teacherBranch}}
Görüşme Tarihi: {{meeting.date}}
Görüşmeyi Yapan: {{teacher.fullName}}

Görüşme Konusu:
{{meeting.topic}}

Paylaşılan Bilgiler:
{{meeting.notes}}

Alınan Kararlar / İzlenecek Yol:
{{meeting.followUp}}

Görüşülen Öğretmen İmza:                                Görüşmeyi Yapan İmza:''',
    tags: ['rehberlik', 'öğretmen görüşme', 'form'],
  ),
  DocumentTemplate(
    id: 'BEP-005',
    title: 'Öğrenci Bilgi Formu',
    categoryId: 'BEP ve Rehberlik',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.fullName', 'document.date'],
    optionalFields: [
      'student.schoolNumber', 'student.birthDate', 'parent.fullName', 'parent.phone',
      'student.strengths', 'student.supportNeeds', 'student.specialNotes', 'student.observations',
    ],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Rehberlik dosyası için öğrenci bilgi ve gözlem formu.',
    bodyText: '''{{school.name}}

ÖĞRENCİ BİLGİ FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Okul No: {{student.schoolNumber}}
Doğum Tarihi: {{student.birthDate}}
Veli: {{parent.fullName}}
Veli Telefon: {{parent.phone}}

Öğrencinin Güçlü Yönleri:
{{student.strengths}}

Desteklenmesi Gereken Alanlar:
{{student.supportNeeds}}

Sağlık / Özel Durum Notu:
{{student.specialNotes}}

Akademik / Sosyal Gözlemler:
{{student.observations}}

Formu Düzenleyen: {{teacher.fullName}} Tarih: {{document.date}}''',
    tags: ['rehberlik', 'öğrenci bilgi', 'form'],
  ),

  // ---- Sınıf / Şube İşlemleri ----
  DocumentTemplate(
    id: 'SNS-001',
    title: 'Sınıf Öğrenci Bilgi Formu',
    categoryId: 'Sınıf / Şube İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.fullName', 'document.date'],
    optionalFields: [
      'student.schoolNumber', 'parent.fullName', 'parent.phone', 'student.address',
      'student.academicNotes', 'student.socialNotes', 'student.interests', 'student.specialNotes',
    ],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınıf/şube rehber öğretmeninin tuttuğu öğrenci bilgi formu.',
    bodyText: '''{{school.name}}

SINIF ÖĞRENCİ BİLGİ FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Okul No: {{student.schoolNumber}}
Veli: {{parent.fullName}}
Veli Telefon: {{parent.phone}}
Adres: {{student.address}}

Akademik Bilgiler:
{{student.academicNotes}}

Sosyal / Davranışsal Gözlemler:
{{student.socialNotes}}

İlgi Alanları:
{{student.interests}}

Özel Notlar:
{{student.specialNotes}}

Sınıf / Şube Rehber Öğretmeni: {{teacher.fullName}} Tarih: {{document.date}}''',
    tags: ['sınıf', 'öğrenci bilgi', 'form'],
  ),
  DocumentTemplate(
    id: 'SNS-002',
    title: 'Şube Rehberlik Aylık Faaliyet Planı',
    categoryId: 'Sınıf / Şube İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'academic.year', 'teacher.fullName', 'student.className', 'plan.period'],
    optionalFields: ['plan.activities'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınıf/şubenin aylık rehberlik faaliyet planı.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{student.className}} ŞUBE REHBERLİK AYLIK FAALİYET PLANI

Rehber Öğretmen: {{teacher.fullName}}
Sınıf / Şube: {{student.className}}
Ay / Dönem: {{plan.period}}

Faaliyetler (Hafta - Tarih - Faaliyet - Amaç - Açıklama, her satıra bir kayıt):
{{plan.activities}}''',
    tags: ['rehberlik', 'aylık plan', 'sınıf'],
  ),
  DocumentTemplate(
    id: 'SNS-003',
    title: 'Sınıf Oturma Planı',
    categoryId: 'Sınıf / Şube İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: ['school.name', 'student.className', 'classroom.room', 'teacher.fullName', 'document.date'],
    optionalFields: ['seatingPlan'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınıfın oturma düzenini gösteren plan.',
    bodyText: '''{{school.name}}

{{student.className}} SINIF OTURMA PLANI

Sınıf / Şube: {{student.className}}
Derslik: {{classroom.room}}
Öğretmen: {{teacher.fullName}}
Tarih: {{document.date}}

Oturma Düzeni (satır/sıra - öğrenci adı, her satıra bir kayıt):
{{seatingPlan}}''',
    tags: ['sınıf', 'oturma planı'],
  ),
  DocumentTemplate(
    id: 'SNS-004',
    title: 'Sınıf Nöbet / Görev Çizelgesi',
    categoryId: 'Sınıf / Şube İşlemleri',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'student.className', 'teacher.fullName', 'plan.period'],
    optionalFields: ['dutySchedule'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınıf içi nöbet/görev dağılımını gösteren çizelge.',
    bodyText: '''{{school.name}}

{{student.className}} SINIF NÖBET / GÖREV ÇİZELGESİ

Sınıf / Şube: {{student.className}}
Sorumlu Öğretmen: {{teacher.fullName}}
Dönem: {{plan.period}}

Görev Dağılımı (Tarih - Öğrenci - Görev - Açıklama, her satıra bir kayıt):
{{dutySchedule}}''',
    tags: ['sınıf', 'nöbet', 'görev çizelgesi'],
  ),

  // ---- Sınav ve Ölçme ----
  DocumentTemplate(
    id: 'SNV-002',
    title: 'Sınav Sonuç Değerlendirme Tutanağı',
    categoryId: 'Sınav ve Ölçme',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'school.name', 'academic.year', 'teacher.branch', 'teacher.fullName',
      'exam.className', 'exam.name', 'exam.date', 'exam.studentCount', 'exam.average', 'document.date',
    ],
    optionalFields: ['exam.analysisItems', 'exam.actions'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir sınavın sonuçlarının kazanım/soru bazında değerlendirildiği tutanak.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

{{teacher.branch}} DERSİ SINAV SONUÇ DEĞERLENDİRME TUTANAĞI

Öğretmen: {{teacher.fullName}}
Sınıf / Şube: {{exam.className}}
Sınav: {{exam.name}}
Sınav Tarihi: {{exam.date}}
Öğrenci Sayısı: {{exam.studentCount}}
Sınıf Ortalaması: {{exam.average}}

Kazanım / Soru Bazlı Değerlendirme (konu - başarı % - açıklama, her satıra bir kayıt):
{{exam.analysisItems}}

Alınacak Önlemler:
{{exam.actions}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['sınav', 'değerlendirme', 'tutanak'],
  ),
];
