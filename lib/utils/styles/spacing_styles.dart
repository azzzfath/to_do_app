import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants/sizes.dart';

class AppSpacingStyle {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.only(
      top: AppSizes.defaultSpace,
      left: AppSizes.defaultSpace,
      right: AppSizes.defaultSpace,
      bottom: AppSizes.defaultSpace);

  static const EdgeInsetsGeometry profilePadding = EdgeInsets.only(
      top: AppSizes.appBarHeight,
      left: AppSizes.defaultSpace,
      right: AppSizes.defaultSpace,
      bottom: AppSizes.defaultSpace);
}
