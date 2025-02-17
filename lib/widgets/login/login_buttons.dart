import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/app_theme.dart';

void _showAuthModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Para que ocupe más espacio
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.mediumPurple.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.play(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 24),
                  enabledBorder: const  UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 24),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              if (title == "Registrarse") ...[
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 20),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, //Insert Signing logic
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.mediumPurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(title, style: GoogleFonts.play(fontSize: 24)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (title == "Iniciar Sesión") ...[
                Text('ó', style: GoogleFonts.play(color: Colors.white, fontSize: 16),),
                Text('inicia sesión con', style: GoogleFonts.play(color: Colors.white, fontSize: 16),)
              ] else if (title == "Registrarse") ...[
                Text('crea una cuenta con', style: GoogleFonts.play(color: Colors.white, fontSize: 16),)
              ],
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cerrar", style: GoogleFonts.play(color: Colors.white70, fontSize: 16)),
              ),
            ],
          ),
        );
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
