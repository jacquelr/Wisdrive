import 'package:flutter/material.dart';

import 'package:quiz_app/data/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

const logo = '../assets/images/logo.png';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient, // Aplicamos el degradado
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo, width: 400),
              const SizedBox(height: 50),
              Text(
                '¡Comencemos a aprender!',
                style: GoogleFonts.play(color: white, fontSize: 42),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'iniciar sesion',
                      style: GoogleFonts.play(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'registrarse',
                      style: GoogleFonts.play(color: purple, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
