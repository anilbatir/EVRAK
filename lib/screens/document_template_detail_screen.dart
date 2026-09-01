import 'package:flutter/material.dart';

import '../data/curriculum/curriculum_catalog.dart';
import '../data/curriculum/yillik_plan_builder.dart';
import '../models/document_template.dart';
import '../models/weekly_plan.dart';
import '../theme/app_theme.dart';
import 'prepare_document_screen.dart';
import 'weekly_plan_screen.dart';

/// Templates for which the real MEB curriculum data (assets/plans/*.json,
/// see lib/data/curriculum/curriculum_catalog.dart) is available - browsable
/// week by week (Kazanımlar) or as one full Yıllık Plan document. Every
/// grade/subject combo in [curriculumCatalog] is offered as a picker option
/// under these two templates.
const _weeklyPlanPilotTemplateIds = {'KZN-001'};
const _yillikPlanPilotTemplateIds = {'PLN-001'};

/// Detail screen for a template-backed document (real, dynamically
/// generated) as opposed to the static demo `EvrakDocument` catalog.
class DocumentTemplateDetailScreen extends StatelessWidget {
  const DocumentTemplateDetailScreen({super.key, required this.template});

  final DocumentTemplate template;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  const SizedBox(width: 44),
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
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(16)),
                        child: const Icon(Icons.auto_awesome_outlined, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(template.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textPrimary)),
                            const SizedBox(height: 4),
                            Text('Otomatik doldurulan belge', style: TextStyle(fontSize: 13, color: textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Açıklama', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textPrimary)),
                  const SizedBox(height: 8),
                  Text(template.description, style: TextStyle(fontSize: 13.5, height: 1.65, color: textSecondary)),
                  const SizedBox(height: 24),
                  Text('Etiketler', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textPrimary)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: template.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(color: const Color(0xFFF1EEFF), borderRadius: BorderRadius.circular(20)),
                        child: Text(tag, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.accent)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 26),
              child: Column(
                children: [
                  if (_weeklyPlanPilotTemplateIds.contains(template.id))
                    for (final combo in curriculumCatalog) ...[
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => WeeklyPlanScreen(assetPath: combo.assetPath),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accent,
                            side: const BorderSide(color: AppColors.accent),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.calendar_view_week_outlined, size: 18),
                          label: Text(
                            '${combo.title} Kazanımlarını Gör',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  if (_yillikPlanPilotTemplateIds.contains(template.id))
                    for (final combo in curriculumCatalog) ...[
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final plan = await WeeklyPlan.loadAsset(combo.assetPath);
                            final builtTemplate = buildYillikPlanTemplate(
                              id: combo.yillikPlanTemplateId,
                              plan: plan,
                            );
                            if (!context.mounted) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PrepareDocumentScreen(template: builtTemplate, weeklyPlan: plan),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accent,
                            side: const BorderSide(color: AppColors.accent),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          icon: const Icon(Icons.description_outlined, size: 18),
                          label: Text(
                            '${combo.title} Yıllık Planını Hazırla',
                            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PrepareDocumentScreen(template: template)),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(Icons.auto_awesome_outlined, color: Colors.white, size: 18),
                      label: const Text('Belgeyi Hazırla', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
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
