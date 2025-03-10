import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/utils/constants/sizes.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._(); //To avoid creating instances

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.buttonSecondary,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.buttonSecondary,
      disabledBackgroundColor: AppColors.buttonAccent,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.normal),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );
}
