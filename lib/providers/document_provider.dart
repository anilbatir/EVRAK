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
  String? _categoryFilter;

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String? get categoryFilter => _categoryFilter;

  List<EvrakDocument> get documents {
    return _documents.where((doc) {
      final matchesQuery = _searchQuery.isEmpty ||
          doc.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (doc.notes?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
      final matchesCategory =
          _categoryFilter == null || doc.category == _categoryFilter;
      return matchesQuery && matchesCategory;
    }).toList();
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
    String? notes,
    required DateTime date,
  }) async {
    final document = EvrakDocument(
      id: _uuid.v4(),
      title: title,
      category: category,
      notes: notes,
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

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategoryFilter(String? category) {
    _categoryFilter = category;
    notifyListeners();
  }
}
