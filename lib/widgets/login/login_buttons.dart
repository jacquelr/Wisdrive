import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/widgets/login/modal_sheet.dart';

void _showAuthModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Para que ocupe más espacio
      builder: (context) {
        return ModalSheet(title: title);
      },
    );
  }

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showAuthModal(context, "Iniciar Sesión"),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, foregroundColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'iniciar sesion',
            style: GoogleFonts.play(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showAuthModal(context, "Registrarse"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'registrarse',
            style: GoogleFonts.play(color: purple, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
