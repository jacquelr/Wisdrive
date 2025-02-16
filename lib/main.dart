import 'package:flutter/material.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/login_screen.dart';

void main() {
  runApp(const WisdriveApp());
}

class WisdriveApp extends StatelessWidget {
  const WisdriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisdrive',
      theme: AppTheme.themeData, // Aplicamos el tema desde theme.dart
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const LoginScreen());
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient, // Usamos el degradado del theme
        ),
        child: Center(
          child: Image.asset('assets/logo.png', width: 100), // Agrega tu logo
        ),
      ),
    );
  }
}