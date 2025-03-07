import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/widgets/login/login_buttons.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import '../../generated/l10n.dart';

const logo = '../assets/images/logo.png';
const lightLogo = '../assets/images/light-logo.png';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getGradient(themeController.isDarkMode.value), // Aplicamos el degradado
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              themeController.isDarkMode.value ? Image.asset(logo, width: 400) : Image.asset(lightLogo, width: 400),
              const SizedBox(height: 50),
              Text(
                S.of(context).lets_start_learning,
                style: GoogleFonts.play(color: themeController.isDarkMode.value ? AppTheme.lightBackground : AppTheme.lightPurple, fontSize: 42),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              const LoginButton(),
              const SizedBox(height: 15),
              const SignupButton(),
            ],
          ),
        ),
      ),
    );
  }
}
