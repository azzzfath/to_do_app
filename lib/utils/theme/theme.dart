import 'package:flutter/material.dart';
import 'package:to_do_app/utils/theme/elevated_button_theme.dart';
import 'package:to_do_app/utils/theme/text_field_theme.dart';
import 'package:to_do_app/utils/theme/text_theme.dart';

import '../constants/colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.accent,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.appTextTheme,
    scaffoldBackgroundColor: AppColors.secondary,
    inputDecorationTheme: AppTextFormFieldTheme.inputDecorationTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonTheme,
  );
}
