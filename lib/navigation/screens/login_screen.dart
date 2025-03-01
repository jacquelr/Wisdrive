import 'package:flutter/material.dart';

import 'package:quiz_app/data/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/widgets/login/login_buttons.dart';
import '../../generated/l10n.dart';

const logo = '../assets/images/logo.png';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.blackBgGradient, // Aplicamos el degradado
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo, width: 400),
              const SizedBox(height: 50),
              Text(
                S.of(context).lets_start_learning,
                style: GoogleFonts.play(color: white, fontSize: 42),
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
