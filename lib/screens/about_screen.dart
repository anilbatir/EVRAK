import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(title: const Text('Hakkımızda')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.description_outlined, color: Colors.white, size: 32),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text('EVRAK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: textPrimary)),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text('Sürüm 1.0.0', style: TextStyle(fontSize: 13, color: textSecondary)),
            ),
            const SizedBox(height: 28),
            Text(
              'EVRAK, öğretmenlerin ihtiyaç duyduğu resmi evrakları kategorilere göre hızlıca bulmasını, '
              'kendi bilgileriyle otomatik olarak kişiselleştirmesini ve PDF olarak oluşturup paylaşmasını '
              'sağlayan bir mobil uygulamadır.',
              style: TextStyle(fontSize: 14, height: 1.7, color: textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              'Amacımız, evrak hazırlama sürecinde öğretmenlerin zamanını almasını engelleyen tekrarlayan '
              'işleri en aza indirmek.',
              style: TextStyle(fontSize: 14, height: 1.7, color: textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
