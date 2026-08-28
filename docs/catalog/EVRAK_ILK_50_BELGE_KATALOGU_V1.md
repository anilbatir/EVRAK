# EVRAK — İlk 50 Belge Kataloğu v1.0

Bu katalog, EVRAK uygulamasının ilk veri ve şablon üretim backlog'udur.

## Statü Tanımları
- `official_form`: MEB veya bağlı resmî birimlerde yayımlanmış form/evrak örneği bulunuyor. Üretimde resmî örnek temel alınmalı; içerik keyfî değiştirilmemeli.
- `official_basis`: Resmî kılavuz/uygulama içinde ilgili belge türü veya yapı yer alıyor; kurum/kademe bazında uyarlama gerekebilir.
- `custom_template`: Öğretmenlerin sık kullandığı belge türü için EVRAK tarafından hazırlanacak kişiselleştirilebilir şablon. “Resmî standart form” gibi sunulmamalı.

## Güvenlik Seviyesi
- `low`: kişisel veri riski düşük
- `medium`: öğretmen/kurum verisi içerir
- `high`: öğrenci, veli veya hassas personel verisi içerebilir

> Uygulamada kullanıcıya gösterilen evrakların güncel mevzuat ve kurum uygulamasıyla uyumlu olduğu ayrıca doğrulanmalıdır. Özellikle `custom_template` belgeler “örnek/kullanıma uyarlanabilir şablon” olarak etiketlenmelidir.


## 01. Görevlendirme Talep Dilekçesi

- **ID:** `ATG-001`
- **Kategori:** Atama ve Görevlendirme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `teacher.branch`, `school.name`, `school.city`, `school.district`, `document.date`
- **Opsiyonel değişkenler:** `teacher.registrationNo`, `teacher.phone`, `document.description`

## 02. Görev Yeri Değişikliği Talep Dilekçesi

- **ID:** `ATG-002`
- **Kategori:** Atama ve Görevlendirme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `school.city`, `school.district`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.branch`, `teacher.registrationNo`

## 03. Geçici Görevlendirme İstek Dilekçesi

- **ID:** `ATG-003`
- **Kategori:** Atama ve Görevlendirme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `teacher.branch`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.registrationNo`, `teacher.phone`

## 04. Göreve Başlama Bildirimi

- **ID:** `ATG-004`
- **Kategori:** Atama ve Görevlendirme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `school.city`, `school.district`, `document.date`
- **Opsiyonel değişkenler:** `teacher.branch`, `teacher.registrationNo`

## 05. Mazeret İzni Talep Dilekçesi

- **ID:** `IZN-001`
- **Kategori:** İzin İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `leave.startDate`, `leave.endDate`, `document.description`
- **Opsiyonel değişkenler:** `teacher.branch`, `teacher.registrationNo`

## 06. Yıllık İzin Talep Dilekçesi

- **ID:** `IZN-002`
- **Kategori:** İzin İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `leave.startDate`, `leave.endDate`
- **Opsiyonel değişkenler:** `teacher.phone`, `teacher.registrationNo`

## 07. Ücretsiz İzin Talep Dilekçesi

- **ID:** `IZN-003`
- **Kategori:** İzin İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `leave.startDate`, `leave.endDate`, `document.description`
- **Opsiyonel değişkenler:** `teacher.registrationNo`

## 08. Doğum Sonrası İzin Talep Dilekçesi

- **ID:** `IZN-004`
- **Kategori:** İzin İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `leave.startDate`, `leave.endDate`
- **Opsiyonel değişkenler:** `teacher.registrationNo`, `document.description`

## 09. Süt İzni Tercih Dilekçesi

- **ID:** `IZN-005`
- **Kategori:** İzin İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.registrationNo`

## 10. Ek Ders Çizelgesi Kişisel Kontrol Formu

- **ID:** `MED-001`
- **Kategori:** Maaş ve Ek Ders
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `teacher.branch`, `school.name`, `document.date`
- **Opsiyonel değişkenler:** `teacher.registrationNo`, `document.description`

## 11. Eksik Ek Ders Ödemesi Düzeltme Dilekçesi

- **ID:** `MED-002`
- **Kategori:** Maaş ve Ek Ders
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.registrationNo`

## 12. Banka / Maaş Bilgisi Güncelleme Dilekçesi

- **ID:** `MED-003`
- **Kategori:** Maaş ve Ek Ders
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`
- **Opsiyonel değişkenler:** `teacher.registrationNo`, `document.description`

## 13. Sene Başı Zümre Öğretmenler Kurulu Toplantı Tutanağı

- **ID:** `KZM-001`
- **Kategori:** Kurul ve Zümre
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `school.city`, `school.district`, `teacher.branch`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `school.principalName`, `document.description`

## 14. Ara Dönem Zümre Toplantı Tutanağı

- **ID:** `KZM-002`
- **Kategori:** Kurul ve Zümre
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `teacher.branch`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `document.description`

## 15. Sene Sonu Zümre Öğretmenler Kurulu Toplantı Tutanağı

- **ID:** `KZM-003`
- **Kategori:** Kurul ve Zümre
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `teacher.branch`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `document.description`

## 16. Şube Öğretmenler Kurulu Toplantı Tutanağı

- **ID:** `KZM-004`
- **Kategori:** Kurul ve Zümre
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `student.className`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `teacher.fullName`, `document.description`

## 17. Öğretmenler Kurulu Karar Takip Formu

- **ID:** `KZM-005`
- **Kategori:** Kurul ve Zümre
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `school.principalName`, `document.description`

## 18. Veli Görüşme Formu

- **ID:** `VEL-001`
- **Kategori:** Veli İşlemleri
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `parent.fullName`, `meeting.date`, `teacher.fullName`
- **Opsiyonel değişkenler:** `student.className`, `meeting.topic`, `document.description`

## 19. Veli Toplantısı Davet Yazısı

- **ID:** `VEL-002`
- **Kategori:** Veli İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `student.className`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `teacher.fullName`, `school.address`

## 20. Veli Toplantısı Tutanağı

- **ID:** `VEL-003`
- **Kategori:** Veli İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `student.className`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `teacher.fullName`, `document.description`

## 21. Veli İzin / Onay Formu

- **ID:** `VEL-004`
- **Kategori:** Veli İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `parent.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `student.className`, `parent.phone`

## 22. Veli Bilgilendirme Tutanağı

- **ID:** `VEL-005`
- **Kategori:** Veli İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `parent.fullName`, `teacher.fullName`, `meeting.date`, `document.description`
- **Opsiyonel değişkenler:** `student.className`

## 23. Bireyselleştirilmiş Eğitim Programı (BEP) Formu

- **ID:** `BEP-001`
- **Kategori:** BEP ve Rehberlik
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`, `teacher.fullName`, `document.startDate`, `document.endDate`
- **Opsiyonel değişkenler:** `teacher.branch`, `document.description`

## 24. BEP Geliştirme Birimi Toplantı Tutanağı

- **ID:** `BEP-002`
- **Kategori:** BEP ve Rehberlik
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `school.name`, `student.fullName`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `teacher.fullName`, `parent.fullName`

## 25. Öğrenci Görüşme Formu

- **ID:** `BEP-003`
- **Kategori:** BEP ve Rehberlik
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `meeting.date`, `teacher.fullName`
- **Opsiyonel değişkenler:** `student.className`, `meeting.topic`, `document.description`

## 26. Öğretmen ile Görüşme Formu

- **ID:** `BEP-004`
- **Kategori:** BEP ve Rehberlik
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `student.fullName`, `document.description`

## 27. Öğrenci Bilgi Formu

- **ID:** `BEP-005`
- **Kategori:** BEP ve Rehberlik
- **Kaynak statüsü:** `official_basis`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`
- **Opsiyonel değişkenler:** `parent.fullName`, `document.description`

## 28. Sınıf Öğrenci Bilgi Formu

- **ID:** `SNS-001`
- **Kategori:** Sınıf / Şube İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`
- **Opsiyonel değişkenler:** `parent.fullName`, `parent.phone`, `document.description`

## 29. Şube Rehberlik Aylık Faaliyet Planı

- **ID:** `SNS-002`
- **Kategori:** Sınıf / Şube İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `student.className`, `document.startDate`, `document.endDate`
- **Opsiyonel değişkenler:** `document.description`

## 30. Sınıf Oturma Planı

- **ID:** `SNS-003`
- **Kategori:** Sınıf / Şube İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `student.className`, `teacher.fullName`
- **Opsiyonel değişkenler:** `document.date`

## 31. Sınıf Nöbet / Görev Çizelgesi

- **ID:** `SNS-004`
- **Kategori:** Sınıf / Şube İşlemleri
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `student.className`, `teacher.fullName`, `document.startDate`, `document.endDate`
- **Opsiyonel değişkenler:** `document.description`

## 32. Sınav Analiz Formu

- **ID:** `SNV-001`
- **Kategori:** Sınav ve Ölçme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `teacher.fullName`, `teacher.branch`, `student.className`, `document.date`
- **Opsiyonel değişkenler:** `document.subject`, `document.description`

## 33. Sınav Sonuç Değerlendirme Tutanağı

- **ID:** `SNV-002`
- **Kategori:** Sınav ve Ölçme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `teacher.fullName`, `teacher.branch`, `student.className`, `document.date`
- **Opsiyonel değişkenler:** `document.description`

## 34. Mazeret Sınavı Talep / Bildirim Formu

- **ID:** `SNV-003`
- **Kategori:** Sınav ve Ölçme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `parent.fullName`

## 35. Sınav Kağıdı Teslim Tutanağı

- **ID:** `SNV-004`
- **Kategori:** Sınav ve Ölçme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `school.name`, `teacher.fullName`, `teacher.branch`, `document.date`
- **Opsiyonel değişkenler:** `document.description`

## 36. Ortak Sınav Görev Tutanağı

- **ID:** `SNV-005`
- **Kategori:** Sınav ve Ölçme
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `school.name`, `teacher.fullName`, `document.date`, `document.subject`
- **Opsiyonel değişkenler:** `document.number`, `document.description`

## 37. Proje Görevi Değerlendirme Formu

- **ID:** `PRJ-001`
- **Kategori:** Proje ve Ödev
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `teacher.fullName`, `teacher.branch`, `document.date`
- **Opsiyonel değişkenler:** `document.subject`, `document.description`

## 38. Performans Görevi Değerlendirme Formu

- **ID:** `PRJ-002`
- **Kategori:** Proje ve Ödev
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `teacher.fullName`, `teacher.branch`, `document.date`
- **Opsiyonel değişkenler:** `document.subject`, `document.description`

## 39. Ödev Takip Formu

- **ID:** `PRJ-003`
- **Kategori:** Proje ve Ödev
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `teacher.fullName`, `document.startDate`, `document.endDate`
- **Opsiyonel değişkenler:** `document.description`

## 40. Proje / Ödev Teslim Tutanağı

- **ID:** `PRJ-004`
- **Kategori:** Proje ve Ödev
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `teacher.fullName`, `document.date`
- **Opsiyonel değişkenler:** `document.subject`, `document.description`

## 41. Demirbaş / Materyal Teslim Tutanağı

- **ID:** `IDR-001`
- **Kategori:** İdari Evraklar
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.registrationNo`

## 42. Anahtar Teslim Tutanağı

- **ID:** `IDR-002`
- **Kategori:** İdari Evraklar
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `medium`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`
- **Opsiyonel değişkenler:** `document.description`

## 43. Ders Defteri / Evrak Teslim Tutanağı

- **ID:** `IDR-003`
- **Kategori:** İdari Evraklar
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `low`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.branch`

## 44. Nöbet Görevi Olay Tutanağı

- **ID:** `IDR-004`
- **Kategori:** İdari Evraklar
- **Kaynak statüsü:** `custom_template`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `teacher.fullName`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `student.fullName`, `student.className`

## 45. İfade Tutanağı

- **ID:** `ODD-001`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.fullName`

## 46. Öğrenci Sözleşmesi

- **ID:** `ODD-002`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`, `document.date`
- **Opsiyonel değişkenler:** `parent.fullName`, `teacher.fullName`, `document.description`

## 47. Şube Rehber Öğretmen Görüş ve Önerileri Formu

- **ID:** `ODD-003`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `teacher.fullName`, `document.date`
- **Opsiyonel değişkenler:** `document.description`

## 48. Savunma Tutanağı

- **ID:** `ODD-004`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `student.fullName`, `student.className`, `school.name`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `teacher.fullName`

## 49. Öğrenci Davranışlarını Değerlendirme Kurulu Toplantı Tutanağı

- **ID:** `ODD-005`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `school.name`, `meeting.date`, `meeting.topic`
- **Opsiyonel değişkenler:** `student.fullName`, `document.description`

## 50. Öğrenci Davranışları Değerlendirme Kurulu Kararı

- **ID:** `ODD-006`
- **Kategori:** Öğrenci Davranışları
- **Kaynak statüsü:** `official_form`
- **Güvenlik:** `high`
- **Zorunlu değişkenler:** `school.name`, `student.fullName`, `student.className`, `document.date`, `document.description`
- **Opsiyonel değişkenler:** `meeting.date`

# Claude Code Uygulama Notu

Bu katalog doğrudan `documentTemplates` seed verisine dönüştürülebilir. Her kayıtta en az şu alanlar bulunmalıdır:

```ts
type SourceStatus = "official_form" | "official_basis" | "custom_template";
type Sensitivity = "low" | "medium" | "high";

interface DocumentTemplate {
  id: string;
  title: string;
  categoryId: string;
  sourceStatus: SourceStatus;
  sensitivity: Sensitivity;
  requiredFields: string[];
  optionalFields: string[];
  outputFormats: ("pdf" | "docx")[];
  version: number;
  lifecycleStatus: "draft" | "review" | "verified" | "deprecated";
  isActive: boolean;
}
```

İlk geliştirme sırasında 50 belgenin tamamını render etmeye çalışmayın. Önce:
1. 1 adet `custom_template`
2. 1 adet `official_form`
ile uçtan uca kişiselleştirme + PDF/DOCX çıktı akışını doğrulayın.
