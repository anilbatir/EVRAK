import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../providers/document_provider.dart';
import '../theme/app_theme.dart';
import 'document_form_screen.dart';

class DocumentDetailScreen extends StatelessWidget {
  const DocumentDetailScreen({super.key, required this.documentId});

  final String documentId;

  Future<void> _confirmDelete(BuildContext context, EvrakDocument document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Evrakı sil'),
        content: Text('"${document.title}" silinsin mi?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Vazgeç')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sil')),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<DocumentProvider>().deleteDocument(document.id);
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<DocumentProvider>();
    final document = provider.allDocuments.firstWhere((d) => d.id == documentId);
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new, size: 18, color: textPrimary),
                  ),
                  Text('Evrak Detayı', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.read<DocumentProvider>().toggleFavorite(document.id),
                        child: Icon(
                          document.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                          size: 24,
                          color: document.isFavorite ? const Color(0xFFF5A623) : textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DocumentFormScreen(document: document)),
                        ),
                        child: Icon(Icons.edit_outlined, size: 20, color: textPrimary),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _confirmDelete(context, document),
                        child: const Icon(Icons.delete_outline, size: 21, color: Color(0xFFE5484D)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: border),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                children: [
                  Row(
                    children: [
                      _DetailFileBadge(fileType: document.fileType),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(document.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textPrimary)),
                            const SizedBox(height: 4),
                            Text('${document.fileType.label} · ${document.sizeLabel}', style: TextStyle(fontSize: 13, color: textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (document.description != null && document.description!.isNotEmpty) ...[
                    Text('Açıklama', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textPrimary)),
                    const SizedBox(height: 8),
                    Text(document.description!, style: TextStyle(fontSize: 13.5, height: 1.65, color: textSecondary)),
                    const SizedBox(height: 24),
                  ],
                  if (document.tags.isNotEmpty) ...[
                    Text('Etiketler', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textPrimary)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: document.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFF1EEFF), borderRadius: BorderRadius.circular(20)),
                          child: Text(tag, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.accent)),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 26),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bu bir demo evrakıdır, indirme henüz bağlı değil.')),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(Icons.file_download_outlined, color: Colors.white, size: 18),
                      label: const Text('İndir', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Paylaşım henüz bağlı değil.')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.darkSurface : const Color(0xFFF4F3FA),
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: Icon(Icons.share_outlined, color: textPrimary, size: 18),
                      label: Text('Paylaş', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textPrimary)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailFileBadge extends StatelessWidget {
  const _DetailFileBadge({required this.fileType});

  final EvrakFileType fileType;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 56,
        height: 56,
        color: fileType.color,
        child: Stack(
          children: [
            Positioned(
              top: -10,
              right: -10,
              child: Transform.rotate(
                angle: 0.785398,
                child: Container(width: 24, height: 24, color: Colors.white.withOpacity(0.3)),
              ),
            ),
            Center(
              child: Text(
                fileType.label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
