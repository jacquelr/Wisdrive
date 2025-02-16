import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/splash_screen.dart';

const logo = '../assets/images/logo.png';

void main() {
  runApp(const WisdriveApp());
}

class WisdriveApp extends StatelessWidget {
  const WisdriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisdrive',
      theme: AppTheme.themeData, // Aplicamos el tema desde theme.dart
      home: const SplashScreen(),
    );
  }
}