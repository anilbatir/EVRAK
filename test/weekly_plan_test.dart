import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/models/weekly_plan.dart';

void main() {
  test('9. Sınıf Matematik yıllık plan verisi 39 kayıt (36 ders haftası + 3 tatil) içerir', () {
    final raw = File('assets/plans/9-matematik.json').readAsStringSync();
    final plan = WeeklyPlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(plan.grade, '9');
    expect(plan.subject, 'Matematik');
    expect(plan.weeks.length, 39);

    final holidayWeeks = plan.weeks.where((w) => w.isHoliday).toList();
    final lessonWeeks = plan.weeks.where((w) => !w.isHoliday).toList();
    expect(holidayWeeks.length, 3);
    expect(lessonWeeks.length, 36);

    for (final week in lessonWeeks) {
      expect(week.unit, isNotNull, reason: '${week.weekLabel} eksik ünite');
      expect(week.kazanimlar, isNotEmpty, reason: '${week.weekLabel} eksik kazanım');
      expect(week.kazanimlar.first.resmiAciklama, isNotNull, reason: '${week.weekLabel} eksik açıklama');
    }

    // Bug regression: the (broken) Günlük Plan source repeated the same
    // kazanım for the whole year. The Yıllık Plan source used here must
    // actually progress through multiple distinct kazanım/units.
    final distinctUnits = lessonWeeks.map((w) => w.unit).toSet();
    expect(distinctUnits.length, greaterThan(1),
        reason: 'yıl boyunca tek bir ünite tekrarlanıyor gibi görünüyor');
  });
}
