import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import 'root_shell.dart';

class OnboardingLoginScreen extends StatefulWidget {
  const OnboardingLoginScreen({super.key});

  @override
  State<OnboardingLoginScreen> createState() => _OnboardingLoginScreenState();
}

class _OnboardingLoginScreenState extends State<OnboardingLoginScreen> {
  final _emailController = TextEditingController(text: 'ayse.yilmaz@ogretmen.com');
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    await context.read<AuthProvider>().login(email: _emailController.text);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 232,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 8,
                      child: Image.asset('assets/images/blob.png', width: 208),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 46),
                      child: Image.asset('assets/images/teacher.png', width: 140),
                    ),
                    Positioned(
                      top: 26,
                      right: 84,
                      child: Image.asset('assets/images/badge_purple.png', width: 36),
                    ),
                    Positioned(
                      top: 108,
                      right: 68,
                      child: Image.asset('assets/images/badge_blue.png', width: 32),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Öğretmenler için evraklara kolay erişim',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, height: 1.28),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Resmi evraklara hızlıca ulaşın, indirin ve işlerinizi kolaylaştırın.',
                      style: TextStyle(fontSize: 12.5, height: 1.55, color: AppColors.lightTextSecondary),
                    ),
                    const SizedBox(height: 22),
                    const Text('E-posta', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 16),
                    const Text('Şifre', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _fieldDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppColors.lightTextSecondary,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Şifremi Unuttum',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _login,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Giriş Yap', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 12.5, color: AppColors.lightTextSecondary),
                          children: [
                            TextSpan(text: 'Hesabın yok mu? '),
                            TextSpan(
                              text: 'Kayıt Ol',
                              style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.accent),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }
}
