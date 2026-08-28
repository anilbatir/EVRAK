# EVRAK — Claude Code Proje Bağlamı

## 1. Ürün Özeti
EVRAK, Türkiye'deki öğretmenlerin ihtiyaç duyduğu okul evraklarını bulmasını, kendi bilgileriyle otomatik kişiselleştirmesini ve PDF/DOCX olarak kullanıma hazır şekilde oluşturmasını sağlayan bir uygulamadır.

Temel ürün vaadi:
**“Dosyayı indir” değil, “Bu evrakı benim adıma hazırla.”**

Bu nedenle sistem statik bir dosya arşivi değil, dinamik belge üretim sistemi olarak tasarlanmalıdır.

## 2. Temel Kullanım Akışı
1. Öğretmen kayıt olur.
2. Profil bilgilerini girer.
3. İhtiyaç duyduğu evrakı seçer.
4. Sistem evrakın gerekli değişkenlerini kontrol eder.
5. Profildeki mevcut bilgiler otomatik doldurulur.
6. Eksik alanlar varsa yalnızca onlar kullanıcıdan istenir.
7. Kullanıcı “Belgeyi Hazırla” der.
8. Master şablon kişiselleştirilir.
9. PDF ve/veya DOCX üretilir.
10. Kullanıcı indirir, paylaşır veya favorilere ekler.

## 3. Master Template Mantığı
Her evrakın tek bir ana şablonu bulunmalıdır.

Örnek:
```text
T.C.
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
İmza:
```

## 4. Variable Schema v1.0

### Teacher
```text
{{teacher.fullName}}
{{teacher.firstName}}
{{teacher.lastName}}
{{teacher.branch}}
{{teacher.title}}
{{teacher.phone}}
{{teacher.email}}
{{teacher.registrationNo}}
{{teacher.serviceYears}}
{{teacher.employmentType}}
{{teacher.nationalId}}
```

`teacher.nationalId` hassas veridir. Yalnız gerçekten gerektiğinde istenmeli; mümkünse kalıcı profilde saklanmamalıdır.

### School
```text
{{school.name}}
{{school.code}}
{{school.city}}
{{school.district}}
{{school.address}}
{{school.principalName}}
```

### Document
```text
{{document.date}}
{{document.subject}}
{{document.number}}
{{document.description}}
{{document.startDate}}
{{document.endDate}}
```

### Ek bağlamsal alanlar
```text
{{student.fullName}}
{{student.className}}
{{parent.fullName}}
{{meeting.date}}
{{meeting.topic}}
{{leave.startDate}}
{{leave.endDate}}
```

Yeni alanlar rastgele isimlendirilmemelidir. Aynı veri tüm belgelerde aynı değişken adıyla kullanılmalıdır.

## 5. Firestore Belge Metadata Modeli
Her evrak `documentTemplates` koleksiyonunda ayrı kayıt olarak tutulmalıdır.

```json
{
  "id": "assignment_request_001",
  "title": "Görevlendirme Talep Dilekçesi",
  "slug": "gorevlendirme-talep-dilekcesi",
  "categoryId": "atama-islemleri",
  "description": "Görevlendirme talebi için kişiselleştirilebilir dilekçe.",
  "templatePath": "templates/atama/gorevlendirme-talep.docx",
  "previewPath": "previews/atama/gorevlendirme-talep.pdf",
  "requiredFields": [
    "teacher.fullName",
    "teacher.branch",
    "school.name",
    "school.city",
    "school.district",
    "document.date"
  ],
  "optionalFields": [
    "teacher.registrationNo",
    "teacher.phone"
  ],
  "outputFormats": ["pdf", "docx"],
  "tags": ["görevlendirme", "atama", "dilekçe"],
  "isVerified": true,
  "isActive": true,
  "version": 1
}
```

## 6. Firebase Mimarisi

### Firestore
```text
users
schools
categories
documentTemplates
favorites
generatedDocuments
```

### Firebase Storage
```text
templates/
  atama-islemleri/
  izin-islemleri/
  maas-ek-ders/
  kurul-zumre/
  veli/
  bep-rehberlik/
  sinav/
  idari/
  diger/

previews/
generated/
```

`templates` master DOCX/HTML şablonlarını, `previews` PDF önizlemelerini, `generated` kullanıcı adına üretilen belgeleri tutar.

## 7. Google Drive Yedek Yapısı
Google Drive ana arşiv/yedek olarak kullanılacaktır.

```text
EVRAK/
├── 01_MASTER_TEMPLATES/
├── 02_PDF_PREVIEWS/
├── 03_TEMPLATE_DATA/
└── 04_ARCHIVE/
```

Firebase canlı uygulama deposudur. Google Drive master/yedek arşivdir.

## 8. İlk Kategori Yapısı
İlk sürüm yaklaşık 50 evrakla başlayacaktır.

1. Atama ve Görevlendirme
2. İzin İşlemleri
3. Maaş ve Ek Ders
4. Kurul ve Zümre
5. Veli İşlemleri
6. BEP ve Rehberlik
7. Sınıf / Şube İşlemleri
8. Sınav ve Ölçme
9. Proje ve Ödev
10. İdari Evraklar
11. Dilekçeler
12. Formlar

## 9. UX Kuralları
Evrak detay ekranında:
- Belge adı
- Kategori
- Açıklama
- Dosya türleri
- Önizleme
- “Belgeyi Hazırla”
- Favoriye ekle
- Paylaş

“Belgeyi Hazırla” akışı:
1. `requiredFields` okunur.
2. Profilde mevcut alanlar otomatik alınır.
3. Eksik alanlar kullanıcıya gösterilir.
4. Kullanıcı onaylar.
5. Şablon render edilir.
6. PDF/DOCX oluşturulur.

Kullanıcıdan her belge için tüm profil bilgileri tekrar istenmemelidir.

## 10. Güvenlik ve KVKK
Özellikle şu alanlar hassastır:
- T.C. Kimlik No
- Telefon
- Adres
- Sicil bilgileri

Gereksiz yere tutulmamalıdır. Mümkünse yalnızca ihtiyaç olduğunda istenmeli ve Firestore Security Rules ile korunmalıdır.

## 11. Belge Doğrulama Sistemi
Her belge şu durumlardan birine sahip olmalıdır:
```text
draft
review
verified
deprecated
```

Kullanıcıya mümkünse yalnızca `verified` ve `isActive == true` belgeler gösterilmelidir.

Her şablonda versiyon tutulmalıdır:
```text
version
updatedAt
verifiedAt
```

## 12. Kritik Teknik Prensip
Statik PDF'leri uygulama bundle/assets içine gömmek ana yöntem olmamalıdır.

Doğru yaklaşım:
**Master template + metadata + değişken schema + belge üretim motoru**

## 13. Claude Code İçin İlk Teknik Görevler
1. Firebase bağlantısını kur.
2. Firestore collection modellerini oluştur.
3. Firebase Storage klasör standardını oluştur.
4. TypeScript `VariableSchema` modelini tanımla.
5. `DocumentTemplate` modelini oluştur.
6. Kullanıcı profil modelini oluştur.
7. `requiredFields` kontrol mekanizmasını geliştir.
8. Dinamik belge hazırlama akışını kur.
9. PDF/DOCX üretim yöntemini belirle.
10. UI ile backend'i bağla.
11. Firestore/Storage Security Rules hazırla.
12. Önce tek bir test belgesiyle uçtan uca sistemi doğrula.
13. Sistem doğrulandıktan sonra evrak kataloğunu toplu şekilde ekle.

## 14. UI / Asset Sorumluluğu
UI/UX tasarımları ve görsel assetler ChatGPT tarafından hazırlanacaktır.

Claude Code:
- Tasarımları mümkün olduğunca birebir kodlamalı,
- Assetleri doğru path ile eklemeli,
- Responsive davranışı kurmalı,
- Firebase ve belge üretim altyapısını geliştirmelidir.

Mevcut tasarım dili:
- temiz
- modern
- sade
- öğretmen odaklı
- beyaz/açık zemin
- mor/mavi vurgu
- yuvarlatılmış kartlar
- kolay kategori erişimi

---
Bu dosya EVRAK'ın ürün ve teknik bağlamının ana referanslarından biridir. Büyük mimari değişiklikler yapılmadan önce bu ürün mantığıyla uyumluluk kontrol edilmelidir.
