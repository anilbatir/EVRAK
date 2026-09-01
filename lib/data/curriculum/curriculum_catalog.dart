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

  String get title => '$grade. Sınıf $subject';

  /// Stable id for the generated Yıllık Plan DocumentTemplate, e.g. PLN-9-BIY.
  String get yillikPlanTemplateId {
    final subjectCode = subject
        .toUpperCase()
        .replaceAll('İ', 'I')
        .replaceAll(RegExp('[^A-Z]'), '')
        .substring(0, subject.length >= 3 ? 3 : subject.length);
    return 'PLN-$grade-$subjectCode';
  }
}

const curriculumCatalog = <CurriculumCombo>[
  CurriculumCombo(grade: '9', subject: 'Matematik', assetPath: 'assets/plans/9-matematik.json'),
  CurriculumCombo(grade: '9', subject: 'Biyoloji', assetPath: 'assets/plans/9-biyoloji.json'),
];
