import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _faqs = [
    (
      'Belgeler nasıl kişiselleştiriliyor?',
      'Profilindeki öğretmen ve okul bilgilerini bir kez doldurduğunda, uygulama uygun belgeleri '
          'senin adına otomatik olarak dolduruyor. Sadece profilinde bulunmayan bilgileri ayrıca girmen yeterli.',
    ),
    (
      'Oluşturduğum belgeyi nasıl paylaşırım?',
      'Belge oluşturulduktan sonra açılan ekrandan PDF olarak indirebilir ya da doğrudan paylaşabilirsin.',
    ),
    (
      'Bir kategoriyi bulamıyorum, ne yapmalıyım?',
      'Ana sayfadaki arama kutusunu veya Kategoriler sekmesindeki büyüteç simgesini kullanarak tüm '
          'evraklar arasında arama yapabilirsin.',
    ),
    (
      'Bilgilerim güvende mi?',
      'Profil bilgilerin yalnızca cihazında saklanır ve belgelerini kişiselleştirmek için kullanılır.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      appBar: AppBar(title: const Text('Yardım ve Destek')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Sık Sorulan Sorular', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: textPrimary)),
            const SizedBox(height: 14),
            ..._faqs.map((faq) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border.all(color: border), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(faq.$1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary)),
                      const SizedBox(height: 8),
                      Text(faq.$2, style: TextStyle(fontSize: 13, height: 1.6, color: textSecondary)),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF1EEFF), borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.mail_outline, color: AppColors.accent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Başka bir sorun mu var?', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.accent)),
                        SizedBox(height: 2),
                        Text('destek@evrakapp.com', style: TextStyle(fontSize: 13, color: AppColors.accent)),
                      ],
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
