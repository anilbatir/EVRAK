import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// One row of an official Yıllık Plan: either a teaching week (with a
/// ünite/tema, kazanım and description) or a holiday/break week.
class WeeklyPlanWeek {
  final String weekLabel;
  final String? month;
  final String? dateRange;
  final String? hours;
  final String? unit;
  final String? kazanim;
  final String? description;
  final bool isHoliday;

  const WeeklyPlanWeek({
    required this.weekLabel,
    this.month,
    this.dateRange,
    this.hours,
    this.unit,
    this.kazanim,
    this.description,
    required this.isHoliday,
  });

  factory WeeklyPlanWeek.fromJson(Map<String, dynamic> json) {
    return WeeklyPlanWeek(
      weekLabel: json['weekLabel'] as String? ?? '',
      month: json['month'] as String?,
      dateRange: json['dateRange'] as String?,
      hours: json['hours'] as String?,
      unit: json['unit'] as String?,
      kazanim: json['kazanim'] as String?,
      description: json['description'] as String?,
      isHoliday: json['isHoliday'] as bool? ?? false,
    );
  }
}

/// A full academic year's Yıllık Plan for one grade/subject, sourced from
/// the teacher's own MEB-based yearly plan document (see
/// assets/plans/README - each file is one grade+subject).
class WeeklyPlan {
  final String grade;
  final String subject;
  final String academicYear;
  final List<WeeklyPlanWeek> weeks;

  const WeeklyPlan({
    required this.grade,
    required this.subject,
    required this.academicYear,
    required this.weeks,
  });

  String get title => '$grade. Sınıf $subject';

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) {
    return WeeklyPlan(
      grade: json['grade'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      academicYear: json['academicYear'] as String? ?? '',
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
