import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/service/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const AuthGate());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.splashBgGradient,
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Image.asset(RImages.wLogo, width: 110),
          ),
        ),
      ),
    );
  }
}
