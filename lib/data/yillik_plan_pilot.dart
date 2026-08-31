import '../models/document_template.dart';

/// Real Yıllık Plan content for the 9. Sınıf Matematik pilot, generated
/// from the teacher's own Drive "Yıllık Plan" document
/// (docs source: assets/plans/9-matematik.json) - NOT hand-typed, so it
/// can't drift from the real 36-week/6-tema curriculum data. Unlike the
/// generic Yıllık Plan template (PLN-001, free-text), this one embeds the
/// actual MEB curriculum for the whole year; only teacher/school info is
/// personalized.
///
/// Surfaced from the Yıllık Plan detail screen as a pilot-only option
/// alongside the generic template - see document_template_detail_screen.dart.
const yillikPlan9MatematikTemplate = DocumentTemplate(
  id: 'PLN-9-MAT',
  title: 'Yıllık Plan — 9. Sınıf Matematik',
  categoryId: 'Planlar',
  sourceStatus: SourceStatus.officialBasis,
  sensitivity: Sensitivity.low,
  requiredFields: [
    'teacher.fullName',
    'teacher.branch',
    'school.name',
  ],
  optionalFields: [
    'school.principalName',
  ],
  outputFormats: ['pdf', 'docx'],
  version: 1,
  lifecycleStatus: LifecycleStatus.verified,
  isActive: true,
  description: '9. Sınıf Matematik dersinin tüm yıl (36 hafta) planının okul/öğretmen bilgileriyle hazırlanan tam belgesi.',
  bodyText: '''T.C.
MİLLÎ EĞİTİM BAKANLIĞI
{{school.name}} MÜDÜRLÜĞÜ
2026-2027 EĞİTİM ÖĞRETİM YILI 9. SINIF MATEMATİK DERSİ YILLIK PLANI

Öğretmen: {{teacher.fullName}}
Branş: {{teacher.branch}}

1. Hafta (14 - 18 Eylül, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

2. Hafta (21 - 25 Eylül, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

3. Hafta (28 Eylül - 02 Ekim, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

4. Hafta (05 - 09 Ekim, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

5. Hafta (12 - 16 Ekim, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

6. Hafta (19 - 23 Ekim, 6 Saat) — 1. TEMA: SAYILAR
Kazanım: MAT.9.1. Gerçek sayılar, üslü ve köklü ifadeler
Açıklama/Beceriler: Sayı kümeleri, üslü ve köklü işlemler, EBOB-EKOK problemleri

7. Hafta (29 Ekim Bayramı) (26 - 30 Ekim, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

8. Hafta (02 - 06 Kasım, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

9. Hafta (09 - 13 Kasım, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

1. ARA TATİL (16 - 20 KASIM 2026)

10. Hafta (23 - 27 Kasım, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

11. Hafta (30 Kasım - 04 Aralık, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

12. Hafta (07 - 11 Aralık, 6 Saat) — 2. TEMA: NİCELİKLER VE DEĞİŞİMLER
Kazanım: MAT.9.2. Denklemler ve Eşitsizlikler
Açıklama/Beceriler: Birinci dereceden denklemler, mutlak değer ve yaş-yüzde problemleri

13. Hafta (14 - 18 Aralık, 6 Saat) — 3. TEMA: ALGORİTMA VE BİLİŞİM
Kazanım: MAT.9.3. Mantık ve Kümeler
Açıklama/Beceriler: Önermeler, mantık kuralları, kümelerde birleşim/kesişim ve akış şemaları

14. Hafta (21 - 25 Aralık, 6 Saat) — 3. TEMA: ALGORİTMA VE BİLİŞİM
Kazanım: MAT.9.3. Mantık ve Kümeler
Açıklama/Beceriler: Önermeler, mantık kuralları, kümelerde birleşim/kesişim ve akış şemaları

15. Hafta (28 Aralık - 01 Ocak, 6 Saat) — 3. TEMA: ALGORİTMA VE BİLİŞİM
Kazanım: MAT.9.3. Mantık ve Kümeler
Açıklama/Beceriler: Önermeler, mantık kuralları, kümelerde birleşim/kesişim ve akış şemaları

16. Hafta (04 - 08 Ocak, 6 Saat) — 3. TEMA: ALGORİTMA VE BİLİŞİM
Kazanım: MAT.9.3. Mantık ve Kümeler
Açıklama/Beceriler: Önermeler, mantık kuralları, kümelerde birleşim/kesişim ve akış şemaları

17. Hafta (11 - 15 Ocak, 6 Saat) — 3. TEMA: ALGORİTMA VE BİLİŞİM
Kazanım: MAT.9.3. Mantık ve Kümeler
Açıklama/Beceriler: Önermeler, mantık kuralları, kümelerde birleşim/kesişim ve akış şemaları

18. Hafta (1. Dönem Sonu) (18 - 22 Ocak, 6 Saat) — OKUL TEMELLİ
Kazanım: 1. Dönem Sonu Okul Temelli Planlama
Açıklama/Beceriler: Sosyal etkinlikler, rehberlik ve genel akademik değerlendirmeler

YARIYIL TATİLİ (SÖMESTR) (25 OCAK - 05 ŞUBAT 2027)

19. Hafta (08 - 12 Şubat, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

20. Hafta (15 - 19 Şubat, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

21. Hafta (22 - 26 Şubat, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

22. Hafta (01 - 05 Mart, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

2. ARA TATİL (Ramazan Bayramı) (08 - 12 MART 2027)

23. Hafta (15 - 19 Mart, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

24. Hafta (22 - 26 Mart, 6 Saat) — 4. TEMA: GEOMETRİK ŞEKİLLER
Kazanım: MAT.9.4. Üçgenler ve Geometri
Açıklama/Beceriler: Üçgende açılar, dik üçgen, Pisagor ve trigonometrik oranlar

25. Hafta (29 Mart - 02 Nisan, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

26. Hafta (05 - 09 Nisan, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

27. Hafta (12 - 16 Nisan, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

28. Hafta (23 Nisan Bayramı) (19 - 23 Nisan, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

29. Hafta (26 - 30 Nisan, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

30. Hafta (03 - 07 Mayıs, 6 Saat) — 5. TEMA: EŞLİK VE BENZERLİK
Kazanım: MAT.9.5. Üçgenlerde Eşlik ve Benzerlik
Açıklama/Beceriler: Eşlik aksiyomları, benzerlik oranları, açıortay ve kenarortay

31. Hafta (10 - 14 Mayıs, 6 Saat) — 6. TEMA: İSTATİSTİKSEL ARAŞTIRMA SÜRECİ
Kazanım: MAT.9.6. Veri Analizi ve İstatistik
Açıklama/Beceriler: Merkezi eğilim/yayılım ölçüleri, grafik okuma ve yorumlama

32. Hafta (19 Mayıs / Kurban B.) (17 - 21 Mayıs, 6 Saat) — 6. TEMA: İSTATİSTİKSEL ARAŞTIRMA SÜRECİ
Kazanım: MAT.9.6. Veri Analizi ve İstatistik
Açıklama/Beceriler: Merkezi eğilim/yayılım ölçüleri, grafik okuma ve yorumlama

33. Hafta (24 - 28 Mayıs, 6 Saat) — 6. TEMA: İSTATİSTİKSEL ARAŞTIRMA SÜRECİ
Kazanım: MAT.9.6. Veri Analizi ve İstatistik
Açıklama/Beceriler: Merkezi eğilim/yayılım ölçüleri, grafik okuma ve yorumlama

34. Hafta (31 Mayıs - 04 Haziran, 6 Saat) — 6. TEMA: İSTATİSTİKSEL ARAŞTIRMA SÜRECİ
Kazanım: MAT.9.6. Veri Analizi ve İstatistik
Açıklama/Beceriler: Merkezi eğilim/yayılım ölçüleri, grafik okuma ve yorumlama

35. Hafta (07 - 11 Haziran, 6 Saat) — 6. TEMA: İSTATİSTİKSEL ARAŞTIRMA SÜRECİ
Kazanım: MAT.9.6. Veri Analizi ve İstatistik
Açıklama/Beceriler: Merkezi eğilim/yayılım ölçüleri, grafik okuma ve yorumlama

36. Hafta (Yıl Sonu) (14 - 18 Haziran, 6 Saat) — OKUL TEMELLİ
Kazanım: Yıl Sonu Okul Temelli Planlama
Açıklama/Beceriler: Sosyal etkinlikler, rehberlik ve genel akademik değerlendirmeler

Öğretmen (İmza): {{teacher.fullName}}
Zümre Başkanı (İmza):

UYGUNDUR
Okul Müdürü (İmza): {{school.principalName}}''',
  tags: ['yıllık plan', 'planlar', 'matematik', '9. sınıf'],
);
