import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/document.dart';
import '../services/database_service.dart';

class DocumentProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  final _uuid = const Uuid();

  List<EvrakDocument> _documents = [];
  bool _isLoading = false;
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  List<EvrakDocument> get allDocuments => _documents;

  List<EvrakDocument> get filteredBySearch {
    if (_searchQuery.isEmpty) return _documents;
    final q = _searchQuery.toLowerCase();
    return _documents.where((doc) {
      return doc.title.toLowerCase().contains(q) ||
          doc.category.toLowerCase().contains(q) ||
          doc.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  List<EvrakDocument> get favorites =>
      _documents.where((d) => d.isFavorite).toList();

  List<EvrakDocument> byCategory(String category) =>
      _documents.where((d) => d.category == category).toList();

  int countForCategory(String category) => byCategory(category).length;

  List<EvrakDocument> get recent {
    final sorted = [..._documents]..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(5).toList();
  }

  Future<void> loadDocuments() async {
    _isLoading = true;
    notifyListeners();
    _documents = await _db.fetchAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addDocument({
    required String title,
    required String category,
    required EvrakFileType fileType,
    required int fileSizeKB,
    String? description,
    List<String> tags = const [],
    required DateTime date,
  }) async {
    final document = EvrakDocument(
      id: _uuid.v4(),
      title: title,
      category: category,
      fileType: fileType,
      fileSizeKB: fileSizeKB,
      description: description,
      tags: tags,
      date: date,
      createdAt: DateTime.now(),
    );
    await _db.insert(document);
    await loadDocuments();
  }

  Future<void> updateDocument(EvrakDocument document) async {
    await _db.update(document);
    await loadDocuments();
  }

  Future<void> deleteDocument(String id) async {
    await _db.delete(id);
    await loadDocuments();
  }

  Future<void> toggleFavorite(String id) async {
    final index = _documents.indexWhere((d) => d.id == id);
    if (index == -1) return;
    final updated = _documents[index].copyWith(isFavorite: !_documents[index].isFavorite);
    _documents[index] = updated;
    notifyListeners();
    await _db.update(updated);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
