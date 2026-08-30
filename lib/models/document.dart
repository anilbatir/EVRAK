import 'package:flutter/material.dart';

enum EvrakFileType { pdf, docx, xlsx }

extension EvrakFileTypeX on EvrakFileType {
  String get label {
    switch (this) {
      case EvrakFileType.pdf:
        return 'PDF';
      case EvrakFileType.docx:
        return 'DOCX';
      case EvrakFileType.xlsx:
        return 'XLSX';
    }
  }

  Color get color {
    switch (this) {
      case EvrakFileType.pdf:
        return const Color(0xFFE5484D);
      case EvrakFileType.docx:
        return const Color(0xFF2F6FED);
      case EvrakFileType.xlsx:
        return const Color(0xFF16A34A);
    }
  }
}

class EvrakCategory {
  final String name;
  final Color color;
  final IconData icon;

  const EvrakCategory({required this.name, required this.color, required this.icon});
}

/// The unified category taxonomy: the 11 categories from the official
/// 50-document catalog (docs/catalog/) plus 5 more surfaced by the
/// "ÖğretmenEvrak" reference app's sidebar (Maarif Evrakları, Planlar,
/// Kulüp Evrakları, Aday Öğretmenlik, Diğer Evraklar). Items from that
/// sidebar that already had a home in the official catalog - Zümre
/// Tutanakları, Veli Toplantı Tutanakları, Rehberlik Raporları - were
/// not duplicated; see lib/data/extended_catalog_seed.dart.
const List<EvrakCategory> evrakCategories = [
  EvrakCategory(name: 'Atama ve Görevlendirme', color: Color(0xFF6C5CE7), icon: Icons.work_outline),
  EvrakCategory(name: 'İzin İşlemleri', color: Color(0xFFF5A623), icon: Icons.event_note_outlined),
  EvrakCategory(name: 'Maaş ve Ek Ders', color: Color(0xFF16A34A), icon: Icons.payments_outlined),
  EvrakCategory(name: 'Kurul ve Zümre', color: Color(0xFF0EA5A5), icon: Icons.groups_outlined),
  EvrakCategory(name: 'Veli İşlemleri', color: Color(0xFFEC4899), icon: Icons.family_restroom_outlined),
  EvrakCategory(name: 'BEP ve Rehberlik', color: Color(0xFF4F46E5), icon: Icons.psychology_outlined),
  EvrakCategory(name: 'Sınıf / Şube İşlemleri', color: Color(0xFF06B6D4), icon: Icons.class_outlined),
  EvrakCategory(name: 'Sınav ve Ölçme', color: Color(0xFFDC2626), icon: Icons.fact_check_outlined),
  EvrakCategory(name: 'Proje ve Ödev', color: Color(0xFFD97706), icon: Icons.assignment_turned_in_outlined),
  EvrakCategory(name: 'İdari Evraklar', color: Color(0xFF64748B), icon: Icons.admin_panel_settings_outlined),
  EvrakCategory(name: 'Öğrenci Davranışları', color: Color(0xFFE11D48), icon: Icons.report_gmailerrorred_outlined),
  EvrakCategory(name: 'Maarif Evrakları', color: Color(0xFF2563EB), icon: Icons.bar_chart_outlined),
  EvrakCategory(name: 'Planlar', color: Color(0xFF7C3AED), icon: Icons.calendar_month_outlined),
  EvrakCategory(name: 'Kulüp Evrakları', color: Color(0xFF65A30D), icon: Icons.diversity_3_outlined),
  EvrakCategory(name: 'Aday Öğretmenlik', color: Color(0xFFEA580C), icon: Icons.school_outlined),
  EvrakCategory(name: 'Diğer Evraklar', color: Color(0xFF6B7280), icon: Icons.folder_outlined),
];

EvrakCategory categoryByName(String name) {
  return evrakCategories.firstWhere(
    (c) => c.name == name,
    orElse: () => evrakCategories.last,
  );
}

class EvrakDocument {
  final String id;
  final String title;
  final String category;
  final EvrakFileType fileType;
  final int fileSizeKB;
  final String? description;
  final List<String> tags;
  final DateTime date;
  final DateTime createdAt;
  final bool isFavorite;

  EvrakDocument({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.fileSizeKB,
    this.description,
    this.tags = const [],
    required this.date,
    required this.createdAt,
    this.isFavorite = false,
  });

  String get sizeLabel {
    if (fileSizeKB >= 1024) {
      return '${(fileSizeKB / 1024).toStringAsFixed(1)} MB';
    }
    return '$fileSizeKB KB';
  }

  EvrakDocument copyWith({
    String? title,
    String? category,
    EvrakFileType? fileType,
    int? fileSizeKB,
    String? description,
    List<String>? tags,
    DateTime? date,
    bool? isFavorite,
  }) {
    return EvrakDocument(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      fileType: fileType ?? this.fileType,
      fileSizeKB: fileSizeKB ?? this.fileSizeKB,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      date: date ?? this.date,
      createdAt: createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'fileType': fileType.name,
      'fileSizeKB': fileSizeKB,
      'description': description,
      'tags': tags.join('|'),
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory EvrakDocument.fromMap(Map<String, dynamic> map) {
    return EvrakDocument(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      fileType: EvrakFileType.values.firstWhere(
        (t) => t.name == map['fileType'],
        orElse: () => EvrakFileType.pdf,
      ),
      fileSizeKB: map['fileSizeKB'] as int,
      description: map['description'] as String?,
      tags: ((map['tags'] as String?) ?? '')
          .split('|')
          .where((t) => t.isNotEmpty)
          .toList(),
      date: DateTime.parse(map['date'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      isFavorite: (map['isFavorite'] as int? ?? 0) == 1,
    );
  }
}
