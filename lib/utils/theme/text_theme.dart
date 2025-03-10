import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants/colors.dart';

class AppTextTheme {
  AppTextTheme._(); // To avoid creating instances

  static TextTheme appTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.primary),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 28.0, fontWeight: FontWeight.w700, color: AppColors.primary),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 22.0, fontWeight: FontWeight.w600, color: AppColors.primary),
    titleLarge: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.primary),
    titleMedium: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: AppColors.primary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.primary),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: AppColors.text),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: AppColors.text),
    bodySmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.text.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColors.text),
    labelMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.text.withOpacity(0.5)),
  );
}
