import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weekly_plan.dart';
import '../theme/app_theme.dart';

/// Swipeable week-by-week viewer for a Yıllık Plan: one week per screen
/// (ünite/tema, kazanım, açıklama), matching the reference app the user
/// shared. The teacher reads a week, writes it into the sınıf defteri,
/// then swipes to the next one. Notes are per-week and stored locally.
class WeeklyPlanScreen extends StatefulWidget {
  const WeeklyPlanScreen({super.key, required this.assetPath});

  final String assetPath;

  @override
  State<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends State<WeeklyPlanScreen> {
  final _pageController = PageController();
  WeeklyPlan? _plan;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WeeklyPlan.loadAsset(widget.assetPath).then((plan) {
      if (mounted) setState(() => _plan = plan);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _editNote(WeeklyPlanWeek week) async {
    final plan = _plan!;
    final prefs = await SharedPreferences.getInstance();
    final key = 'weekly_plan_note_${plan.grade}_${plan.subject}_${week.weekLabel}';
    final controller = TextEditingController(text: prefs.getString(key) ?? '');

    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkSurface : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${week.weekLabel} Notu', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 4,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Bu hafta için notunu yaz...',
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    await prefs.setString(key, controller.text);
                    if (context.mounted) Navigator.of(context).pop();
                    setState(() {});
                  },
                  style: FilledButton.styleFrom(backgroundColor: AppColors.accent),
                  child: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final plan = _plan;
    if (plan == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new, size: 18, color: textPrimary),
                  ),
                  Expanded(
                    child: Text(
                      plan.title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: plan.weeks.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final week = plan.weeks[i];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    child: week.isHoliday
                        ? _HolidayCard(week: week, textPrimary: textPrimary, textSecondary: textSecondary)
                        : _WeekCard(
                            week: week,
                            border: border,
                            textPrimary: textPrimary,
                            textSecondary: textSecondary,
                            onAddNote: () => _editNote(week),
                          ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '${_index + 1} / ${plan.weeks.length}',
                style: TextStyle(fontSize: 12.5, color: textSecondary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({
    required this.week,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.onAddNote,
  });

  final WeeklyPlanWeek week;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  week.weekLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                if (week.dateRange != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${week.dateRange}${week.hours != null ? ' · ${week.hours} Saat' : ''}',
                    style: const TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (week.unit != null) ...[
                  const _SectionLabel(label: 'Ünite / Tema'),
                  const SizedBox(height: 6),
                  Text(week.unit!, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: textPrimary)),
                  const SizedBox(height: 18),
                ],
                if (week.kazanim != null) ...[
                  const _SectionLabel(label: 'Kazanım'),
                  const SizedBox(height: 6),
                  Text(week.kazanim!, style: TextStyle(fontSize: 14, height: 1.5, color: textPrimary)),
                  const SizedBox(height: 18),
                ],
                if (week.description != null) ...[
                  const _SectionLabel(label: 'Açıklama / Beceriler'),
                  const SizedBox(height: 6),
                  Text(week.description!, style: TextStyle(fontSize: 13.5, height: 1.6, color: textSecondary)),
                  const SizedBox(height: 20),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: onAddNote,
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Not Ekle'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HolidayCard extends StatelessWidget {
  const _HolidayCard({required this.week, required this.textPrimary, required this.textSecondary});

  final WeeklyPlanWeek week;
  final Color textPrimary;
  final Color textSecondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EEFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.beach_access_outlined, color: AppColors.accent, size: 32),
          const SizedBox(height: 14),
          Text(
            week.weekLabel,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.accent),
          ),
          if (week.dateRange != null) ...[
            const SizedBox(height: 6),
            Text(week.dateRange!, style: const TextStyle(fontSize: 13, color: AppColors.accent, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.accent, letterSpacing: 0.4),
    );
  }
}
