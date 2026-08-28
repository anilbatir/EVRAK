import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import 'onboarding_login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    Future<void> logout() async {
      await context.read<AuthProvider>().logout();
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const OnboardingLoginScreen()),
          (route) => false,
        );
      }
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
                  const SizedBox(width: 20),
                  Text('Profil', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: textPrimary)),
                  Icon(Icons.settings_outlined, color: textPrimary),
                ],
              ),
            ),
            Divider(height: 1, color: border),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
              child: Row(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(color: const Color(0xFFF1EEFF), shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        _initials(auth.userName),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.accent),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(auth.userName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textPrimary)),
                        const SizedBox(height: 6),
                        Text(auth.userEmail, style: TextStyle(fontSize: 13, color: textSecondary)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(color: const Color(0xFFF1EEFF), borderRadius: BorderRadius.circular(20)),
                          child: const Text('Öğretmen', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(border: Border.all(color: border), borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          _MenuRow(icon: Icons.file_download_outlined, label: 'İndirilenler', border: border, color: textPrimary),
                          _MenuRow(icon: Icons.history, label: 'Son Görüntülenenler', border: border, color: textPrimary),
                          _MenuRow(
                            icon: Icons.settings_outlined,
                            label: 'Ayarlar',
                            border: border,
                            color: textPrimary,
                            trailing: Switch(
                              value: themeProvider.isDarkMode,
                              activeColor: AppColors.accent,
                              onChanged: (_) => context.read<ThemeProvider>().toggle(),
                            ),
                          ),
                          _MenuRow(icon: Icons.help_outline, label: 'Yardım ve Destek', border: border, color: textPrimary),
                          _MenuRow(icon: Icons.info_outline, label: 'Hakkımızda', border: border, color: textPrimary, isLast: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: logout,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurface : const Color(0xFFF4F3FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text('Çıkış Yap', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: Color(0xFFE5484D))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.isNotEmpty ? parts.first.substring(0, 1).toUpperCase() : '?';
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.border,
    required this.color,
    this.trailing,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final Color border;
  final Color color;
  final Widget? trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: border)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: color))),
          trailing ?? Icon(Icons.chevron_right, size: 16, color: color.withOpacity(0.4)),
        ],
      ),
    );
  }
}
