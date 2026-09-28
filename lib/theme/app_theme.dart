export 'app_colors.dart';
export 'app_text_styles.dart';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme  {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(brightness: Brightness.light, primary: AppColors.primary, onPrimary: AppColors.text, secondary: AppColors.secondary, onSecondary: AppColors.text, error: AppColors.error, onError: AppColors.background, surface: AppColors.surface, onSurface: AppColors.text),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
      ),
    )
  );
}