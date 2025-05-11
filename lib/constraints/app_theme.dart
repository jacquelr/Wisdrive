import 'package:flutter/material.dart';

const black = Colors.black;
const blackPurple = Color.fromARGB(255, 21, 0, 22);
const deepPurple = Color.fromARGB(255, 41, 16, 74);
const purple = Color.fromARGB(255, 82, 44, 93);
const white = Color.fromARGB(255, 255, 227, 216);
const royalPurple = Color.fromARGB(255, 118, 0, 124);
const violet = Color.fromARGB(255, 151, 71, 255);

class AppTheme {
  // 🎨 Dark colors palette 
  static const Color darkPurple = Color(0xFF281845);
  static const Color mediumPurple = Color(0xFF512A80);
  static const Color lightPurple = Color(0xFF8A52C3);

  // 🎨 White color palette
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightPrimary = Color(0xFFBB86FC);
  static const Color lightSecondary = Color(0xFF6200EE);
  static const Color lightAccent = Color(0xFF3700B3);

  // 🌌 Dark gradient
  static const LinearGradient splashBgGradient = LinearGradient(
    colors: [darkPurple, mediumPurple, lightPurple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient blackBgGradient = LinearGradient(
    colors: [mediumPurple, blackPurple, black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient invertedBlackBgGradient = LinearGradient(
    colors: [blackPurple, mediumPurple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // 🌞 Light gradient
  static const LinearGradient lightBgGradient = LinearGradient(
    colors: [lightBackground, lightPrimary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient invertedLightBgGradient = LinearGradient(
    colors: [lightSecondary, lightPrimary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient whiteGradient = LinearGradient(
    colors: [lightBackground, Colors.white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient getGradient(bool isDarkMode) {
    return isDarkMode ? blackBgGradient : lightBgGradient;
  }

  static LinearGradient getInvertedGradient(bool isDarkMode) {
    return isDarkMode ? invertedBlackBgGradient : invertedLightBgGradient;
  }

  static LinearGradient getWhiteGradient(bool isDarkMode) {
    return isDarkMode ? blackBgGradient : whiteGradient;
  }

  // 🌙 Dark theme
  static ThemeData get darkTheme {
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

  // ☀️ Light theme
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: lightBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
