import 'package:flutter/material.dart';

class AppColors {
  static const accent = Color(0xFF6C5CE7);

  static const lightBg = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF7F6FB);
  static const lightBorder = Color(0xFFECEAF4);
  static const lightTextPrimary = Color(0xFF211F35);
  static const lightTextSecondary = Color(0xFF9A97B0);

  static const darkBg = Color(0xFF0B0A12);
  static const darkSurface = Color(0xFF15131F);
  static const darkBorder = Color(0xFF221F30);
  static const darkTextPrimary = Color(0xFFF3F1FA);
  static const darkTextSecondary = Color(0xFF8A85A6);
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      dividerColor: AppColors.lightBorder,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      dividerColor: AppColors.darkBorder,
    );
  }
}
