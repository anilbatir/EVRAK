import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../models/document_template.dart';
import '../theme/app_theme.dart';

class DocumentResultScreen extends StatelessWidget {
  const DocumentResultScreen({super.key, required this.template, required this.file});

  final DocumentTemplate template;
  final File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Belge Hazır')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(color: Color(0xFFE4F8EC), shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: Color(0xFF16A34A), size: 40),
            ),
            const SizedBox(height: 20),
            Text(template.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text(
              'Belgen PDF olarak oluşturuldu ve cihazına kaydedildi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Color(0xFF9A97B0)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Share.shareXFiles([XFile(file.path)], text: template.title),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.share_outlined, color: Colors.white, size: 18),
                label: const Text('Paylaş', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Ana Sayfaya Dön'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
