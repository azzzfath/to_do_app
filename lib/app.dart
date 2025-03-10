import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/nav_bar.dart';
import 'package:to_do_app/utils/constants/text_strings.dart';
import 'package:to_do_app/utils/theme/theme.dart';
import 'package:to_do_app/views/home.dart';
import 'package:to_do_app/views/to_do_detail.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: AppTexts.appName, theme: AppTheme.theme, home: NavigationMenu());
  }
}
