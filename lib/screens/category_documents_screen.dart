import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../providers/document_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/file_badge.dart';
import 'document_detail_screen.dart';

class CategoryDocumentsScreen extends StatefulWidget {
  const CategoryDocumentsScreen({super.key, this.category});

  /// If null, searches across all categories ("Evrak Ara").
  final String? category;

  @override
  State<CategoryDocumentsScreen> createState() => _CategoryDocumentsScreenState();
}

class _CategoryDocumentsScreenState extends State<CategoryDocumentsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<DocumentProvider>();
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fieldBg = isDark ? AppColors.darkSurface : const Color(0xFFF5F4FA);

    var docs = widget.category != null
        ? provider.byCategory(widget.category!)
        : provider.allDocuments;

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      docs = docs.where((d) => d.title.toLowerCase().contains(q)).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new, size: 18, color: textPrimary),
                  ),
                  Text(
                    widget.category ?? 'Evrak Ara',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 16, color: textSecondary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (v) => setState(() => _query = v),
                              style: TextStyle(fontSize: 13.5, color: textPrimary),
                              decoration: InputDecoration(
                                hintText: 'Evrak ara...',
                                hintStyle: TextStyle(color: textSecondary, fontSize: 13.5),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                              child: Icon(Icons.close, size: 15, color: textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: fieldBg, shape: BoxShape.circle),
                    child: Icon(Icons.tune, size: 17, color: textPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: docs.isEmpty
                  ? Center(child: Text('Evrak bulunamadı', style: TextStyle(color: textSecondary)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => DocumentDetailScreen(documentId: doc.id)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(border: Border.all(color: border), borderRadius: BorderRadius.circular(14)),
                            child: Row(
                              children: [
                                FileBadge(fileType: doc.fileType),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(doc.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary)),
                                      const SizedBox(height: 2),
                                      Text('${doc.fileType.label} · ${doc.sizeLabel}', style: TextStyle(fontSize: 12, color: textSecondary)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.file_download_outlined, size: 17, color: textPrimary),
                                const SizedBox(width: 14),
                                GestureDetector(
                                  onTap: () => context.read<DocumentProvider>().toggleFavorite(doc.id),
                                  child: Icon(
                                    doc.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 20,
                                    color: doc.isFavorite ? const Color(0xFFF5A623) : textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
