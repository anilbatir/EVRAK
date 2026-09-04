/// Registry of grade/subject combinations that have a real, validated
/// assets/plans/*.json curriculum file. Add one entry here per new
/// grade/subject the teacher supplies (via ChatGPT-generated Yıllık Plan
/// source data) - both the Kazanımlar weekly viewer and the Yıllık Plan
/// document generator read from this single list.
class CurriculumCombo {
  final String grade;
  final String subject;
  final String assetPath;

  const CurriculumCombo({
    required this.grade,
    required this.subject,
    required this.assetPath,
  });

  String get title => grade.contains('-') ? '$grade. Sınıflar $subject' : '$grade. Sınıf $subject';

  /// Stable id for the generated Yıllık Plan DocumentTemplate, e.g. PLN-9-BIY.
  /// Subjects that differ only by a trailing Roman numeral (e.g. "Matematik
  /// Uygulamaları I" / "II") would otherwise collide on the same 3-letter
  /// code, so that numeral is kept as an explicit suffix.
  String get yillikPlanTemplateId {
    final words = subject.trim().split(RegExp(r'\s+'));
    final firstWordLetters = words.first
        .toUpperCase()
        .replaceAll('İ', 'I')
        .replaceAll(RegExp('[^A-Z]'), '');
    final code = firstWordLetters.substring(0, firstWordLetters.length >= 3 ? 3 : firstWordLetters.length);
    final lastWord = words.last;
    final hasRomanSuffix = words.length > 1 && RegExp(r'^[IVX]+$').hasMatch(lastWord);
    final suffix = hasRomanSuffix ? '-$lastWord' : '';
    return 'PLN-$grade-$code$suffix';
  }
}

const curriculumCatalog = <CurriculumCombo>[
  CurriculumCombo(grade: '9', subject: 'Matematik', assetPath: 'assets/plans/9-matematik.json'),
  CurriculumCombo(grade: '9', subject: 'Biyoloji', assetPath: 'assets/plans/9-biyoloji.json'),
  CurriculumCombo(grade: '9', subject: 'Din Kültürü ve Ahlak Bilgisi', assetPath: 'assets/plans/9-din-kulturu.json'),
  CurriculumCombo(grade: '4', subject: 'Türkçe', assetPath: 'assets/plans/4-turkce.json'),
  CurriculumCombo(grade: '9-11', subject: 'Matematik Uygulamaları I', assetPath: 'assets/plans/9-11-matematik-uygulamalari-1.json'),
  CurriculumCombo(grade: '9-11', subject: 'Matematik Uygulamaları II', assetPath: 'assets/plans/9-11-matematik-uygulamalari-2.json'),
];
