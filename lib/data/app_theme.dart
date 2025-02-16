import 'package:flutter/material.dart';

const blackPurple = Color.fromARGB(255, 21, 0, 22);
const deepPurple = Color.fromARGB(255, 41, 16, 74);
const purple = Color.fromARGB(255, 82, 44, 93);
const white = Color.fromARGB(255, 255, 227, 216);
const royalPurple = Color.fromARGB(255, 118, 0, 124);
const violet = Color.fromARGB(255, 151, 71, 255);

class AppTheme {
  // Definimos los colores de la paleta
  static const Color darkPurple = Color(0xFF281845);
  static const Color mediumPurple = Color(0xFF512A80);
  static const Color lightPurple = Color(0xFF8A52C3);

  // Definimos el gradiente de fondo
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [darkPurple, mediumPurple, lightPurple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Tema global para la app
  static ThemeData get themeData {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkPurple,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}