import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/teacher_profile.dart';
import '../providers/profile_provider.dart';
import '../theme/app_theme.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _controllers = {
      'fullName': TextEditingController(text: profile.teacher.fullName),
      'branch': TextEditingController(text: profile.teacher.branch),
      'title': TextEditingController(text: profile.teacher.title),
      'phone': TextEditingController(text: profile.teacher.phone),
      'email': TextEditingController(text: profile.teacher.email),
      'registrationNo': TextEditingController(text: profile.teacher.registrationNo),
      'schoolName': TextEditingController(text: profile.school.name),
      'schoolCity': TextEditingController(text: profile.school.city),
      'schoolDistrict': TextEditingController(text: profile.school.district),
      'schoolAddress': TextEditingController(text: profile.school.address),
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final profile = context.read<ProfileProvider>();
    await profile.save(
      teacher: TeacherProfile(
        fullName: _controllers['fullName']!.text.trim(),
        branch: _controllers['branch']!.text.trim(),
        title: _controllers['title']!.text.trim(),
        phone: _controllers['phone']!.text.trim(),
        email: _controllers['email']!.text.trim(),
        registrationNo: _controllers['registrationNo']!.text.trim(),
      ),
      school: SchoolProfile(
        name: _controllers['schoolName']!.text.trim(),
        city: _controllers['schoolCity']!.text.trim(),
        district: _controllers['schoolDistrict']!.text.trim(),
        address: _controllers['schoolAddress']!.text.trim(),
      ),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil bilgilerin kaydedildi.')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    InputDecoration decoration(String label) => InputDecoration(
          labelText: label,
          filled: true,
          fillColor: fieldBg,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgilerim'),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Öğretmen Bilgileri', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text(
            'Bu bilgiler, evrakları otomatik doldururken kullanılır.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF9A97B0)),
          ),
          const SizedBox(height: 16),
          TextField(controller: _controllers['fullName'], decoration: decoration('Ad Soyad')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['branch'], decoration: decoration('Branş')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['title'], decoration: decoration('Unvan')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['phone'], decoration: decoration('Telefon'), keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          TextField(controller: _controllers['email'], decoration: decoration('E-posta'), keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          TextField(controller: _controllers['registrationNo'], decoration: decoration('Sicil No')),
          const SizedBox(height: 28),
          const Text('Okul Bilgileri', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          TextField(controller: _controllers['schoolName'], decoration: decoration('Okul Adı')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['schoolCity'], decoration: decoration('İl')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['schoolDistrict'], decoration: decoration('İlçe')),
          const SizedBox(height: 12),
          TextField(controller: _controllers['schoolAddress'], decoration: decoration('Okul Adresi'), maxLines: 2),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Kaydet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
