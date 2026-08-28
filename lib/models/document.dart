class EvrakDocument {
  final String id;
  final String title;
  final String category;
  final String? notes;
  final DateTime date;
  final DateTime createdAt;

  EvrakDocument({
    required this.id,
    required this.title,
    required this.category,
    this.notes,
    required this.date,
    required this.createdAt,
  });

  EvrakDocument copyWith({
    String? title,
    String? category,
    String? notes,
    DateTime? date,
  }) {
    return EvrakDocument(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'notes': notes,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EvrakDocument.fromMap(Map<String, dynamic> map) {
    return EvrakDocument(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      notes: map['notes'] as String?,
      date: DateTime.parse(map['date'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}

const List<String> evrakCategories = [
  'Fatura',
  'Sözleşme',
  'Kimlik',
  'Sağlık',
  'Eğitim',
  'Diğer',
];
