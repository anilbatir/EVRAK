import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../providers/document_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/file_badge.dart';
import 'document_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<DocumentProvider>();
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final favorites = provider.favorites;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text('Favorilerim', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary)),
                  Icon(Icons.search, color: textPrimary),
                ],
              ),
            ),
            Divider(height: 1, color: border),
            Expanded(
              child: favorites.isEmpty
                  ? Center(
                      child: Text('Henüz favori evrakın yok', style: TextStyle(color: textSecondary)),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final doc = favorites[index];
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
                                      Text(doc.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary)),
                                      const SizedBox(height: 2),
                                      Text('${doc.fileType.label} · ${doc.sizeLabel}', style: TextStyle(fontSize: 12, color: textSecondary)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.read<DocumentProvider>().toggleFavorite(doc.id),
                                  child: const Icon(Icons.star_rounded, size: 22, color: Color(0xFFF5A623)),
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
