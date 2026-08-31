import '../models/document_template.dart';

/// Second batch from the user's ChatGPT workflow (Google Drive "EVRAK"
/// folder) - the remaining documents that complete the official 50-item
/// catalog: the rest of Atama ve Görevlendirme and Sınav ve Ölçme, plus
/// three categories with no coverage before this batch (Proje ve Ödev,
/// İdari Evraklar, Öğrenci Davranışları).
///
/// Same flattening approach as imported_templates.dart: Mustache-style
/// `{{#list}}...{{/list}}` sections became one free-text field per list.
/// This batch was noticeably less consistent than the first - several
/// files (PRJ-001..004, IDR-001..003, SNV-004) wrote a repeating table
/// row's placeholders directly in the body with no `{{#...}}`/`{{/...}}`
/// wrapper at all (just a floating `{{index}} {{title}} ...` line and a
/// "should be repeated" note) - not something EVRAK's engine could have
/// rendered as-is either way, so it made no difference to the flattening.
const List<DocumentTemplate> importedTemplatesBatch2 = [
  // ---- Atama ve Görevlendirme (kalan) ----
  DocumentTemplate(
    id: 'ATG-002',
    title: 'Görev Yeri Değişikliği Talep Dilekçesi',
    categoryId: 'Atama ve Görevlendirme',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'teacher.branch', 'school.name', 'school.city', 'school.district',
      'document.date', 'request.reason', 'request.requestedInstitution',
    ],
    optionalFields: ['teacher.registrationNo', 'request.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Görev yerinin değiştirilmesini talep etmek için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Görev Yeri Değişikliği Talebi

{{teacher.branch}} öğretmeni olarak görev yapmaktayım. {{request.reason}} nedeniyle görev yerimin {{request.requestedInstitution}} kurumuna/yerleşimine değiştirilmesi hususundaki talebimin ilgili mevzuat ve yetkili makam değerlendirmesi kapsamında incelenmesini arz ederim.

Açıklama: {{request.notes}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
Sicil No: {{teacher.registrationNo}}
İmza:''',
    tags: ['atama', 'görev yeri', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'ATG-003',
    title: 'Geçici Görevlendirme İstek Dilekçesi',
    categoryId: 'Atama ve Görevlendirme',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'school.name', 'school.city', 'school.district', 'document.date',
      'request.reason', 'request.startDate', 'request.endDate', 'request.assignmentPlace',
    ],
    optionalFields: ['teacher.branch', 'teacher.registrationNo', 'request.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Geçici görevlendirme talebinde bulunmak için kullanılan dilekçe.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Geçici Görevlendirme İsteği

{{request.reason}} nedeniyle {{request.startDate}} - {{request.endDate}} tarihleri arasında {{request.assignmentPlace}} biriminde/kurumunda geçici olarak görevlendirilmek istiyorum. Talebimin uygun görülmesi hususunda gereğini arz ederim.

Açıklama: {{request.notes}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
Branş: {{teacher.branch}}
Sicil No: {{teacher.registrationNo}}
İmza:''',
    tags: ['atama', 'geçici görevlendirme', 'dilekçe'],
  ),
  DocumentTemplate(
    id: 'ATG-004',
    title: 'Göreve Başlama Bildirimi',
    categoryId: 'Atama ve Görevlendirme',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'teacher.fullName', 'teacher.branch', 'teacher.title', 'school.name',
      'assignment.startDate', 'assignment.unit', 'assignment.reference', 'approver.fullName',
    ],
    optionalFields: [],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir personelin göreve başladığını kayıt altına alan bildirim.',
    bodyText: '''T.C.
{{school.name}}

GÖREVE BAŞLAMA BİLDİRİMİ

Ad Soyad: {{teacher.fullName}}
Branş / Unvan: {{teacher.branch}} / {{teacher.title}}
Göreve Başlama Tarihi: {{assignment.startDate}}
Görevlendirildiği Birim: {{assignment.unit}}
Dayanak / Onay Bilgisi: {{assignment.reference}}

Yukarıda bilgileri bulunan personel, belirtilen tarihte görevine başlamıştır. İşbu bildirim kayıt altına alınmak üzere düzenlenmiştir.

Personel İmza:

Yetkili Ad Soyad: {{approver.fullName}} İmza:''',
    tags: ['atama', 'göreve başlama', 'bildirim'],
  ),

  // ---- Sınav ve Ölçme (kalan) ----
  DocumentTemplate(
    id: 'SNV-001',
    title: 'Sınav Analiz Formu',
    categoryId: 'Sınav ve Ölçme',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: [
      'school.name', 'academic.year', 'teacher.fullName', 'teacher.branch',
      'exam.className', 'exam.name', 'exam.date', 'exam.studentCount', 'exam.average',
    ],
    optionalFields: ['exam.generalEvaluation', 'exam.analysisItems', 'exam.actions'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir sınavın soru/kazanım bazında analiz edildiği form.',
    bodyText: '''{{school.name}}
{{academic.year}} EĞİTİM ÖĞRETİM YILI

SINAV ANALİZ FORMU

Öğretmen: {{teacher.fullName}}
Branş: {{teacher.branch}}
Sınıf / Şube: {{exam.className}}
Sınav: {{exam.name}}
Sınav Tarihi: {{exam.date}}
Öğrenci Sayısı: {{exam.studentCount}}
Sınıf Ortalaması: {{exam.average}}

Soru / Kazanım Bazlı Analiz (konu - başarı % - not, her satıra bir kayıt):
{{exam.analysisItems}}

Genel Değerlendirme:
{{exam.generalEvaluation}}

Planlanan İyileştirmeler:
{{exam.actions}}''',
    tags: ['sınav', 'analiz', 'form'],
  ),
  DocumentTemplate(
    id: 'SNV-003',
    title: 'Mazeret Sınavı Talep / Bildirim Formu',
    categoryId: 'Sınav ve Ölçme',
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'student.fullName', 'student.className', 'school.name', 'school.city', 'school.district',
      'exam.name', 'exam.date', 'exam.absenceReason', 'document.date',
    ],
    optionalFields: ['parent.fullName', 'exam.notes'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınava katılamayan bir öğrenci için mazeret sınavı talep etmek/bildirmek için kullanılan form.',
    bodyText: '''T.C.
{{school.city}} VALİLİĞİ
{{school.district}} KAYMAKAMLIĞI
{{school.name}} MÜDÜRLÜĞÜNE

Konu: Mazeret Sınavı Talebi / Bildirimi

{{student.fullName}} adlı, {{student.className}} sınıfındaki öğrencinin {{exam.name}} sınavına {{exam.absenceReason}} nedeniyle katılamadığına ilişkin mazeretinin değerlendirilmesini ve uygun görülmesi hâlinde mazeret sınavına alınmasını arz ederim.

Sınav tarihi: {{exam.date}}
Açıklama / Ek belge: {{exam.notes}}

Veli Ad Soyad: {{parent.fullName}}
Veli İmza:

Tarih: {{document.date}}''',
    tags: ['sınav', 'mazeret', 'form'],
  ),
  DocumentTemplate(
    id: 'SNV-004',
    title: 'Sınav Kağıdı Teslim Tutanağı',
    categoryId: 'Sınav ve Ölçme',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: ['school.name', 'teacher.fullName', 'teacher.branch', 'document.date', 'academic.year', 'receiver.fullName'],
    optionalFields: ['examPaperDeliveries'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Sınav kağıtlarının teslim edildiğini kayıt altına alan tutanak.',
    bodyText: '''{{school.name}}

SINAV KAĞIDI TESLİM TUTANAĞI

Öğretmen: {{teacher.fullName}}
Branş: {{teacher.branch}}
Teslim Tarihi: {{document.date}}
Eğitim Öğretim Yılı: {{academic.year}}

Teslim Edilen Sınav Kağıtları (Sınıf - Sınav - Evrak Sayısı - Açıklama, her satıra bir kayıt):
{{examPaperDeliveries}}

Teslim Eden: {{teacher.fullName}} İmza:
Teslim Alan: {{receiver.fullName}} İmza:''',
    tags: ['sınav', 'teslim tutanağı'],
  ),
  DocumentTemplate(
    id: 'SNV-005',
    title: 'Ortak Sınav Görev Tutanağı',
    categoryId: 'Sınav ve Ölçme',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: ['school.name', 'exam.name', 'exam.date', 'exam.time', 'exam.room'],
    optionalFields: ['exam.incidentNotes', 'exam.staff', 'exam.materials'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Ortak sınavda görevli öğretmenlerin ve sınav sürecinin kaydedildiği tutanak.',
    bodyText: '''{{school.name}}

ORTAK SINAV GÖREV TUTANAĞI

Sınav: {{exam.name}}
Sınav Tarihi: {{exam.date}}
Saat: {{exam.time}}
Salon / Sınıf: {{exam.room}}

Görevli Öğretmenler (Ad Soyad - Görev, her satıra bir kişi):
{{exam.staff}}

Sınav Süreci / Olay Kaydı:
{{exam.incidentNotes}}

Teslim Edilen Evraklar (Evrak - Adet, her satıra bir kayıt):
{{exam.materials}}''',
    tags: ['sınav', 'görev tutanağı'],
  ),

  // ---- Proje ve Ödev ----
  DocumentTemplate(
    id: 'PRJ-001',
    title: 'Proje Görevi Değerlendirme Formu',
    categoryId: 'Proje ve Ödev',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.branch', 'teacher.fullName', 'project.topic', 'project.deliveryDate'],
    optionalFields: ['project.criteria', 'project.totalScore', 'project.generalEvaluation'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrencinin proje görevinin ölçütlere göre değerlendirildiği form.',
    bodyText: '''{{school.name}}

PROJE GÖREVİ DEĞERLENDİRME FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Ders: {{teacher.branch}}
Öğretmen: {{teacher.fullName}}
Proje Konusu: {{project.topic}}
Teslim Tarihi: {{project.deliveryDate}}

Değerlendirme Ölçütleri (Ölçüt - Ağırlık - Puan - Açıklama, her satıra bir kayıt):
{{project.criteria}}

Toplam Puan: {{project.totalScore}}

Genel Değerlendirme:
{{project.generalEvaluation}}''',
    tags: ['proje', 'değerlendirme', 'form'],
  ),
  DocumentTemplate(
    id: 'PRJ-002',
    title: 'Performans Görevi Değerlendirme Formu',
    categoryId: 'Proje ve Ödev',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.medium,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.branch', 'teacher.fullName', 'performance.topic', 'performance.deliveryDate'],
    optionalFields: ['performance.criteria', 'performance.totalScore', 'performance.generalEvaluation'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrencinin performans görevinin ölçütlere göre değerlendirildiği form.',
    bodyText: '''{{school.name}}

PERFORMANS GÖREVİ DEĞERLENDİRME FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Ders: {{teacher.branch}}
Öğretmen: {{teacher.fullName}}
Görev Konusu: {{performance.topic}}
Teslim Tarihi: {{performance.deliveryDate}}

Değerlendirme Ölçütleri (Ölçüt - Ağırlık - Puan - Açıklama, her satıra bir kayıt):
{{performance.criteria}}

Toplam Puan: {{performance.totalScore}}

Genel Değerlendirme:
{{performance.generalEvaluation}}''',
    tags: ['performans görevi', 'değerlendirme', 'form'],
  ),
  DocumentTemplate(
    id: 'PRJ-003',
    title: 'Ödev Takip Formu',
    categoryId: 'Proje ve Ödev',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.fullName', 'teacher.branch', 'assignment.period'],
    optionalFields: ['assignment.items', 'assignment.teacherNote'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrencinin ödevlerinin veriliş/teslim ve durumunun takip edildiği form.',
    bodyText: '''{{school.name}}

ÖDEV TAKİP FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Öğretmen: {{teacher.fullName}}
Ders: {{teacher.branch}}
Takip Dönemi: {{assignment.period}}

Ödevler (Ödev - Veriliş - Teslim - Durum - Not, her satıra bir kayıt):
{{assignment.items}}

Öğretmen Değerlendirmesi: {{assignment.teacherNote}}''',
    tags: ['ödev', 'takip formu'],
  ),
  DocumentTemplate(
    id: 'PRJ-004',
    title: 'Proje / Ödev Teslim Tutanağı',
    categoryId: 'Proje ve Ödev',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'teacher.fullName', 'teacher.branch', 'document.date'],
    optionalFields: ['submission.items'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrencinin proje/ödev teslim ettiğini kayıt altına alan tutanak.',
    bodyText: '''{{school.name}}

PROJE / ÖDEV TESLİM TUTANAĞI

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Öğretmen: {{teacher.fullName}}
Ders: {{teacher.branch}}
Teslim Tarihi: {{document.date}}

Teslim Edilen Çalışmalar (Çalışma - Tür - Açıklama, her satıra bir kayıt):
{{submission.items}}

Teslim Eden Öğrenci İmza:
Teslim Alan Öğretmen İmza:''',
    tags: ['proje', 'ödev', 'teslim tutanağı'],
  ),

  // ---- İdari Evraklar ----
  DocumentTemplate(
    id: 'IDR-001',
    title: 'Demirbaş / Materyal Teslim Tutanağı',
    categoryId: 'İdari Evraklar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'issuer.fullName', 'teacher.fullName', 'document.date', 'assignment.unit'],
    optionalFields: ['assets'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Demirbaş veya materyal teslim edildiğini kayıt altına alan tutanak.',
    bodyText: '''{{school.name}}

DEMİRBAŞ / MATERYAL TESLİM TUTANAĞI

Teslim Eden: {{issuer.fullName}}
Teslim Alan: {{teacher.fullName}}
Teslim Tarihi: {{document.date}}
Birim: {{assignment.unit}}

Malzemeler (Malzeme - Demirbaş No - Adet - Durum, her satıra bir kayıt):
{{assets}}

Teslim Eden İmza:                                Teslim Alan İmza:''',
    tags: ['idari', 'demirbaş', 'teslim tutanağı'],
  ),
  DocumentTemplate(
    id: 'IDR-002',
    title: 'Anahtar Teslim Tutanağı',
    categoryId: 'İdari Evraklar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'issuer.fullName', 'teacher.fullName', 'document.date'],
    optionalFields: ['keys'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Anahtar teslim edildiğini kayıt altına alan tutanak.',
    bodyText: '''{{school.name}}

ANAHTAR TESLİM TUTANAĞI

Teslim Eden: {{issuer.fullName}}
Teslim Alan: {{teacher.fullName}}
Teslim Tarihi: {{document.date}}

Anahtarlar (Bölüm - Adet - Açıklama, her satıra bir kayıt):
{{keys}}

Teslim Eden İmza:                                Teslim Alan İmza:''',
    tags: ['idari', 'anahtar', 'teslim tutanağı'],
  ),
  DocumentTemplate(
    id: 'IDR-003',
    title: 'Ders Defteri / Evrak Teslim Tutanağı',
    categoryId: 'İdari Evraklar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.low,
    requiredFields: ['school.name', 'teacher.fullName', 'teacher.branch', 'receiver.fullName', 'document.date'],
    optionalFields: ['deliveredDocuments'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Ders defteri veya benzeri evrakların teslim edildiğini kayıt altına alan tutanak.',
    bodyText: '''{{school.name}}

DERS DEFTERİ / EVRAK TESLİM TUTANAĞI

Teslim Eden: {{teacher.fullName}}
Branş: {{teacher.branch}}
Teslim Alan: {{receiver.fullName}}
Teslim Tarihi: {{document.date}}

Teslim Edilen Evraklar (Evrak - Dönem/Sınıf - Açıklama, her satıra bir kayıt):
{{deliveredDocuments}}

Teslim Eden İmza:                                Teslim Alan İmza:''',
    tags: ['idari', 'evrak teslim', 'tutanak'],
  ),
  DocumentTemplate(
    id: 'IDR-004',
    title: 'Nöbet Görevi Olay Tutanağı',
    categoryId: 'İdari Evraklar',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'teacher.fullName', 'duty.location', 'document.date', 'incident.time', 'incident.summary'],
    optionalFields: ['incident.people', 'incident.actions', 'incident.witnesses'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Nöbet sırasında yaşanan bir olayın kaydedildiği tutanak.',
    bodyText: '''{{school.name}}

NÖBET GÖREVİ OLAY TUTANAĞI

Görevli Öğretmen: {{teacher.fullName}}
Nöbet Yeri: {{duty.location}}
Tarih: {{document.date}}
Saat: {{incident.time}}

Olayın Özeti:
{{incident.summary}}

İlgili Kişiler (Ad Soyad - Rol, her satıra bir kişi):
{{incident.people}}

Yapılan İşlemler / Alınan Önlemler:
{{incident.actions}}

Tanıklar (Ad Soyad, her satıra bir kişi):
{{incident.witnesses}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['idari', 'nöbet', 'olay tutanağı'],
  ),

  // ---- Öğrenci Davranışları ----
  DocumentTemplate(
    id: 'ODD-001',
    title: 'İfade Tutanağı',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'document.date', 'meeting.location', 'incident.summary', 'student.statement'],
    optionalFields: ['committeeMembers'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrenciden alınan ifadenin kaydedildiği tutanak.',
    bodyText: '''{{school.name}}

İFADE TUTANAĞI

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Tarih: {{document.date}}
Görüşme Yeri: {{meeting.location}}

Olay / Konu:
{{incident.summary}}

Öğrencinin İfadesi:
{{student.statement}}

Tutanağı Düzenleyenler (Ad Soyad - Rol, her satıra bir kişi):
{{committeeMembers}}

Öğrenci İmza:''',
    tags: ['öğrenci davranışları', 'ifade tutanağı'],
  ),
  DocumentTemplate(
    id: 'ODD-002',
    title: 'Öğrenci Sözleşmesi',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'parent.fullName', 'teacher.fullName', 'document.date'],
    optionalFields: ['behaviorAgreement.goals', 'behaviorAgreement.followUp'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Öğrencinin davranış hedeflerini takip etmek için öğrenci/veli/öğretmen arasında yapılan sözleşme.',
    bodyText: '''{{school.name}}

ÖĞRENCİ SÖZLEŞMESİ

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Veli: {{parent.fullName}}
Tarih: {{document.date}}

Bu sözleşme; öğrencinin gelişimini desteklemek, belirlenen davranış hedeflerini takip etmek ve okul-aile iş birliğini güçlendirmek amacıyla hazırlanmıştır.

Hedefler / Taahhütler:
{{behaviorAgreement.goals}}

Takip ve Değerlendirme:
{{behaviorAgreement.followUp}}

Öğrenci İmza:

Veli İmza:

Öğretmen: {{teacher.fullName}} İmza:''',
    tags: ['öğrenci davranışları', 'sözleşme'],
  ),
  DocumentTemplate(
    id: 'ODD-003',
    title: 'Şube Rehber Öğretmen Görüş ve Önerileri Formu',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name',
      'student.fullName', 'student.className', 'teacher.fullName', 'document.date',
      'studentEvaluation.academic', 'studentEvaluation.attendance', 'studentEvaluation.behavior',
      'studentEvaluation.recommendations',
    ],
    optionalFields: ['studentEvaluation.parentCooperation'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Şube rehber öğretmeninin bir öğrenci hakkındaki görüş ve önerilerini kaydettiği form.',
    bodyText: '''{{school.name}}

ŞUBE REHBER ÖĞRETMEN GÖRÜŞ VE ÖNERİLERİ FORMU

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Rehber Öğretmen: {{teacher.fullName}}
Tarih: {{document.date}}

Akademik Durum:
{{studentEvaluation.academic}}

Devam / Geç Kalma Durumu:
{{studentEvaluation.attendance}}

Davranış ve Sosyal Uyum:
{{studentEvaluation.behavior}}

Veli İş Birliği:
{{studentEvaluation.parentCooperation}}

Görüş ve Öneriler:
{{studentEvaluation.recommendations}}

Tarih: {{document.date}}
Ad Soyad: {{teacher.fullName}}
İmza:''',
    tags: ['öğrenci davranışları', 'rehberlik', 'form'],
  ),
  DocumentTemplate(
    id: 'ODD-004',
    title: 'Savunma Tutanağı',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'student.fullName', 'student.className', 'document.date', 'meeting.location', 'incident.summary', 'student.defense'],
    optionalFields: ['committeeMembers'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Bir öğrenciden alınan savunmanın kaydedildiği tutanak.',
    bodyText: '''{{school.name}}

SAVUNMA TUTANAĞI

Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}
Tarih: {{document.date}}
Yer: {{meeting.location}}

Hakkında Açıklama İstenen Olay:
{{incident.summary}}

Öğrencinin Savunması:
{{student.defense}}

Tutanağı Düzenleyenler (Ad Soyad - Rol, her satıra bir kişi):
{{committeeMembers}}

Öğrenci İmza:''',
    tags: ['öğrenci davranışları', 'savunma tutanağı'],
  ),
  DocumentTemplate(
    id: 'ODD-005',
    title: 'Öğrenci Davranışlarını Değerlendirme Kurulu Toplantı Tutanağı',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: ['school.name', 'meeting.date', 'meeting.time', 'meeting.location', 'committee.chairName'],
    optionalFields: ['committeeMembers', 'agendaItems', 'caseItems', 'decisions'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Öğrenci davranışlarını değerlendirme kurulu toplantısının tutanağı.',
    bodyText: '''{{school.name}}

ÖĞRENCİ DAVRANIŞLARINI DEĞERLENDİRME KURULU TOPLANTI TUTANAĞI

Toplantı Tarihi: {{meeting.date}}
Saat: {{meeting.time}}
Yer: {{meeting.location}}
Başkan: {{committee.chairName}}

Katılımcılar (Ad Soyad - Rol, her satıra bir kişi):
{{committeeMembers}}

Gündem:
{{agendaItems}}

Görüşülen Öğrenci / Konular (Öğrenci - Sınıf - Özet, her satıra bir kayıt):
{{caseItems}}

Alınan Kararlar:
{{decisions}}''',
    tags: ['öğrenci davranışları', 'kurul', 'tutanak'],
  ),
  DocumentTemplate(
    id: 'ODD-006',
    title: 'Öğrenci Davranışları Değerlendirme Kurulu Kararı',
    categoryId: 'Öğrenci Davranışları',
    sourceStatus: SourceStatus.customTemplate,
    sensitivity: Sensitivity.high,
    requiredFields: [
      'school.name',
      'decision.number', 'document.date', 'student.fullName', 'student.className',
      'incident.summary', 'decision.evaluation', 'decision.text',
    ],
    optionalFields: ['decision.evidence', 'committeeMembers'],
    outputFormats: ['pdf', 'docx'],
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description: 'Öğrenci davranışları değerlendirme kurulunun aldığı kararın belgesi.',
    bodyText: '''{{school.name}}

ÖĞRENCİ DAVRANIŞLARI DEĞERLENDİRME KURULU KARARI

Karar No: {{decision.number}}
Karar Tarihi: {{document.date}}
Öğrenci: {{student.fullName}}
Sınıf / Şube: {{student.className}}

Değerlendirilen Olay / Konu:
{{incident.summary}}

İncelenen Bilgi ve Belgeler:
{{decision.evidence}}

Kurul Değerlendirmesi:
{{decision.evaluation}}

Karar:
{{decision.text}}

Kurul Üyeleri (Ad Soyad - Rol, her satıra bir kişi):
{{committeeMembers}}''',
    tags: ['öğrenci davranışları', 'kurul kararı'],
  ),
];
