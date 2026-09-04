import '../../models/document_template.dart';
import '../../models/weekly_plan.dart';

/// Builds a full-year Yıllık Plan [DocumentTemplate] straight from a
/// [WeeklyPlan] loaded from assets/plans/*.json - the body text is composed
/// entirely from the JSON's week data, never hand-typed, so it can't drift
/// out of sync with the Kazanımlar (weekly viewer) screen that reads the
/// same asset. Only teacher/school info is left as `{{...}}` placeholders;
/// the curriculum content itself is baked in per grade/subject.
DocumentTemplate buildYillikPlanTemplate({
  required String id,
  required WeeklyPlan plan,
  String categoryId = 'Planlar',
}) {
  return DocumentTemplate(
    id: id,
    title: 'Yıllık Plan — ${plan.title}',
    categoryId: categoryId,
    sourceStatus: SourceStatus.officialBasis,
    sensitivity: Sensitivity.low,
    requiredFields: const ['teacher.fullName', 'teacher.branch', 'school.name'],
    optionalFields: const ['school.principalName'],
    outputFormats: const ['pdf', 'docx'],
    version: 1,
    lifecycleStatus: LifecycleStatus.verified,
    isActive: true,
    description:
        '${plan.title} dersinin tüm yıl (${plan.weeks.where((w) => !w.isHoliday).length} hafta) planının okul/öğretmen bilgileriyle hazırlanan tam belgesi.',
    bodyText: _buildBodyText(plan),
    tags: ['yıllık plan', 'planlar', plan.subject.toLowerCase(), '${plan.grade}. sınıf'],
  );
}

String _buildBodyText(WeeklyPlan plan) {
  final buffer = StringBuffer()
    ..writeln('T.C.')
    ..writeln('MİLLÎ EĞİTİM BAKANLIĞI')
    ..writeln('{{school.name}} MÜDÜRLÜĞÜ')
    ..writeln('${plan.academicYear} EĞİTİM ÖĞRETİM YILI ${plan.title.toUpperCase()} DERSİ YILLIK PLANI')
    ..writeln()
    ..writeln('Öğretmen: {{teacher.fullName}}')
    ..writeln('Branş: {{teacher.branch}}');
  if (plan.weeklyHours != null && plan.weeklyHours!.isNotEmpty) {
    buffer.writeln('Haftalık Ders Saati: ${plan.weeklyHours}');
  }
  buffer.writeln();

  for (final week in plan.weeks) {
    if (week.isHoliday) {
      final range = (week.dateRange ?? '').isNotEmpty ? ' (${week.dateRange})' : '';
      buffer
        ..writeln('${week.weekLabel}$range')
        ..writeln();
      continue;
    }

    final topicPart = (week.topic ?? '').isNotEmpty ? ' — ${week.topic}' : (week.unit ?? '').isNotEmpty ? ' — ${week.unit}' : '';
    final range = (week.dateRange ?? '').isNotEmpty ? ' (${week.dateRange}' : ' (';
    final hoursPart = (week.hours ?? '').isNotEmpty ? ', ${week.hours} Saat)' : ')';
    buffer.writeln('${week.weekLabel}$range$hoursPart$topicPart');
    if ((week.unit ?? '').isNotEmpty && week.topic != null && week.topic!.isNotEmpty) {
      buffer.writeln('Ünite: ${week.unit}');
    }

    if (week.kazanimlar.any((k) => (k.beceriAlani ?? '').isNotEmpty)) {
      // Dersler like İlkokul/Ortaokul Türkçe track several skill domains
      // (Dinleme/İzleme, Konuşma, Okuma, Yazma) per week instead of one
      // linear kazanım - group by domain so the document reads the way
      // the official plan does, not as one undifferentiated list.
      final byDomain = <String, List<KazanimEntry>>{};
      for (final k in week.kazanimlar) {
        byDomain.putIfAbsent(k.beceriAlani ?? 'Diğer', () => []).add(k);
      }
      for (final domain in byDomain.keys) {
        buffer.writeln('$domain:');
        for (final k in byDomain[domain]!) {
          final kod = (k.kod ?? '').isNotEmpty ? '${k.kod}. ' : '';
          buffer.writeln('  $kod${k.kazanim}');
        }
      }
    } else {
      for (final k in week.kazanimlar) {
        final kod = (k.kod ?? '').isNotEmpty ? '${k.kod} ' : '';
        final saat = (k.saat ?? '').isNotEmpty ? ' (${k.saat} Saat)' : '';
        buffer.writeln('Kazanım: $kod${k.kazanim}$saat');
        if ((k.resmiAciklama ?? '').isNotEmpty) {
          buffer.writeln('Açıklama: ${k.resmiAciklama}');
        }
      }
    }
    if ((week.yontemTeknik ?? '').isNotEmpty) {
      buffer.writeln('Yöntem-Teknik: ${week.yontemTeknik}');
    }
    if ((week.olcme ?? '').isNotEmpty) {
      buffer.writeln('Ölçme: ${week.olcme}');
    }
    if ((week.aciklama ?? '').isNotEmpty) {
      buffer.writeln('Belirli Gün/Hafta: ${week.aciklama}');
    }
    buffer.writeln();
  }

  buffer
    ..writeln('Öğretmen (İmza): {{teacher.fullName}}')
    ..writeln('Zümre Başkanı (İmza):')
    ..writeln()
    ..writeln('UYGUNDUR')
    ..write('Okul Müdürü (İmza): {{school.principalName}}');

  return buffer.toString();
}
