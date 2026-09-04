import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// One kazanım taught within a week, with its own official curriculum
/// explanation and hour share - a week can carry more than one when a
/// topic only partially fills the week (e.g. "12.1.1.1 (2 Saat)" followed
/// by "12.1.2.1 (4 Saat)" in the same week).
class KazanimEntry {
  final String? kod;
  final String kazanim;
  final String? resmiAciklama;
  final String? saat;

  /// Which language-skill domain this kazanım belongs to (Dinleme/İzleme,
  /// Konuşma, Okuma, Yazma) - only set for dersler (e.g. İlkokul/Ortaokul
  /// Türkçe) whose official plan tracks multiple skill areas per week
  /// instead of one linear kazanım progression. Null for every other ders.
  final String? beceriAlani;

  const KazanimEntry({
    this.kod,
    required this.kazanim,
    this.resmiAciklama,
    this.saat,
    this.beceriAlani,
  });

  factory KazanimEntry.fromJson(Map<String, dynamic> json) {
    return KazanimEntry(
      kod: json['kod'] as String?,
      kazanim: json['kazanim'] as String? ?? '',
      resmiAciklama: json['resmiAciklama'] as String?,
      saat: json['saat'] as String?,
      beceriAlani: json['beceriAlani'] as String?,
    );
  }
}

/// One row of an official Yıllık Plan: either a teaching week (ünite/konu,
/// one or more kazanımlar, ölçme, yöntem-teknik) or a holiday/break week.
class WeeklyPlanWeek {
  final String weekLabel;
  final String? month;
  final String? dateRange;
  final String? hours;
  final String? unit;
  final String? topic;
  final List<KazanimEntry> kazanimlar;
  final String? olcme;
  final String? yontemTeknik;
  final String? aciklama;
  final bool isHoliday;

  const WeeklyPlanWeek({
    required this.weekLabel,
    this.month,
    this.dateRange,
    this.hours,
    this.unit,
    this.topic,
    this.kazanimlar = const [],
    this.olcme,
    this.yontemTeknik,
    this.aciklama,
    required this.isHoliday,
  });

  factory WeeklyPlanWeek.fromJson(Map<String, dynamic> json) {
    final rawList = json['kazanimlar'] as List<dynamic>?;
    final kazanimlar = rawList != null
        ? rawList.map((k) => KazanimEntry.fromJson(k as Map<String, dynamic>)).toList()
        : _legacySingleKazanim(json);

    return WeeklyPlanWeek(
      weekLabel: json['weekLabel'] as String? ?? '',
      month: json['month'] as String?,
      dateRange: json['dateRange'] as String?,
      hours: json['hours'] as String?,
      unit: json['unit'] as String?,
      topic: json['topic'] as String?,
      kazanimlar: kazanimlar,
      olcme: json['olcme'] as String?,
      yontemTeknik: json['yontemTeknik'] as String?,
      aciklama: json['aciklama'] as String?,
      isHoliday: json['isHoliday'] as bool? ?? false,
    );
  }

  /// Reads the pre-multi-kazanım schema (single `kazanimKod`/`kazanim`/
  /// `icerik` fields) so any not-yet-migrated JSON still loads correctly.
  static List<KazanimEntry> _legacySingleKazanim(Map<String, dynamic> json) {
    final kazanim = json['kazanim'] as String?;
    if (kazanim == null || kazanim.isEmpty) return const [];
    return [
      KazanimEntry(
        kod: json['kazanimKod'] as String?,
        kazanim: kazanim,
        resmiAciklama: (json['icerik'] ?? json['description']) as String?,
        saat: json['hours'] as String?,
      ),
    ];
  }
}

/// A full academic year's Yıllık Plan for one grade/subject, sourced from
/// the teacher's own MEB-based yearly plan document (see
/// assets/plans/README - each file is one grade+subject).
class WeeklyPlan {
  final String grade;
  final String subject;
  final String academicYear;
  final String? weeklyHours;
  final List<WeeklyPlanWeek> weeks;

  const WeeklyPlan({
    required this.grade,
    required this.subject,
    required this.academicYear,
    this.weeklyHours,
    required this.weeks,
  });

  String get title => '$grade. Sınıf $subject';

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) {
    return WeeklyPlan(
      grade: json['grade'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      academicYear: json['academicYear'] as String? ?? '',
      weeklyHours: json['weeklyHours'] as String?,
      weeks: (json['weeks'] as List<dynamic>? ?? [])
          .map((w) => WeeklyPlanWeek.fromJson(w as Map<String, dynamic>))
          .toList(),
    );
  }

  static Future<WeeklyPlan> loadAsset(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return WeeklyPlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
