import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../providers/document_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/file_badge.dart';
import 'categories_screen.dart';
import 'category_documents_screen.dart';
import 'document_detail_screen.dart';
import 'document_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<DocumentProvider>();
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final cardBg = isDark ? AppColors.darkSurface : null;
    final cardBorder = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DocumentFormScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<DocumentProvider>().loadDocuments(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: textPrimary),
                  Text('Ana Sayfa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary)),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.notifications_outlined, color: textPrimary),
                      if (isDark)
                        Positioned(
                          top: -1,
                          right: -1,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5484D),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.darkBg, width: 1.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF8B7CF6), AppColors.accent, Color(0xFF4C3FC9)],
                        )
                      : null,
                  color: isDark ? null : AppColors.accent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 20, height: 1.4),
                        children: [
                          TextSpan(text: 'Hoş geldiniz,\n', style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFEFEBFF))),
                          TextSpan(text: 'iyi çalışmalar!', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBg : Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: provider.setSearchQuery,
                              style: TextStyle(fontSize: 14, color: textPrimary),
                              decoration: InputDecoration(
                                hintText: 'Evrak ara...',
                                hintStyle: TextStyle(color: textSecondary, fontSize: 14),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          Icon(Icons.search, size: 17, color: textPrimary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kategoriler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary)),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                    ),
                    child: Text('Tümünü Gör', style: TextStyle(fontSize: 13, color: textSecondary)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.55,
                children: evrakCategories.take(4).map((cat) {
                  return _CategoryCard(
                    category: cat,
                    count: provider.countForCategory(cat.name),
                    isDark: isDark,
                    cardBg: cardBg,
                    cardBorder: isDark ? cardBorder : null,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              Text('Son Eklenenler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary)),
              const SizedBox(height: 10),
              ...provider.recent.map((doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DocumentRow(
                      document: doc,
                      isDark: isDark,
                      cardBorder: cardBorder,
                      textPrimary: textPrimary,
                      textSecondary: textSecondary,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.count,
    required this.isDark,
    required this.cardBg,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
  });

  final EvrakCategory category;
  final int count;
  final bool isDark;
  final Color? cardBg;
  final Color? cardBorder;
  final Color textPrimary;
  final Color textSecondary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CategoryDocumentsScreen(category: category.name)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg ?? category.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: cardBorder != null ? Border.all(color: cardBorder!) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(11)),
              child: Icon(category.icon, color: Colors.white, size: 18),
            ),
            const Spacer(),
            Text(category.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary)),
            const SizedBox(height: 3),
            Text('$count evrak', style: TextStyle(fontSize: 12, color: textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.document,
    required this.isDark,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
  });

  final EvrakDocument document;
  final bool isDark;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DocumentDetailScreen(documentId: document.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          border: Border.all(color: cardBorder),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            FileBadge(fileType: document.fileType),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text('${document.fileType.label} · ${document.sizeLabel}', style: TextStyle(fontSize: 12, color: textSecondary)),
                ],
              ),
            ),
            Icon(Icons.file_download_outlined, size: 18, color: textPrimary),
          ],
        ),
      ),
    );
  }
}
