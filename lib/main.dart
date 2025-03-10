import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/controllers/language_controller.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/profile_screen.dart';
import 'package:quiz_app/navigation/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

const logo = '../assets/images/logo.png';

void main() {
  Get.put(ThemeController());
  Get.put(LanguageController());
  runApp(const WisdriveApp());
}

class WisdriveApp extends StatelessWidget {
  const WisdriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.find();

    return GetMaterialApp(
      locale: languageController.selectedLocale.value, // Idioma dinamico
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Wisdrive',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ProfileScreen(),
    );
  }
}
