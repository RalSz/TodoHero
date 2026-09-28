import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _familyAlike = 'Alike';
  static const String _familyAlegreya = 'AlegreyaSans';

  static const TextStyle title = TextStyle(
    fontFamily: _familyAlike,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: _familyAlegreya,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _familyAlegreya,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static const TextStyle bodyLined = TextStyle(
    fontFamily: _familyAlegreya,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textLined,
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.text,
  );
}