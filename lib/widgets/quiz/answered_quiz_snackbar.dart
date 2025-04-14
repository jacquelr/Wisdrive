import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';

class AnsweredQuizSnackbar {
  static void show(BuildContext context, bool isCorrect) {
    final icon = isCorrect
        ? const Icon(Icons.check_circle, color: white, size: 28)
        : const Icon(Icons.cancel_rounded, color: white, size: 28);

    final message = isCorrect ? S.of(context).correct : S.of(context).incorrect;

    final backgroundColor = isCorrect ? Colors.green[600] : Colors.red[600];

    final player = AudioPlayer();

    void playSound() async {
      isCorrect
          ? await player.play(AssetSource(RAutoPlayer.correct))
          : await player.play(AssetSource(RAutoPlayer.incorrect));
    }
    playSound();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        content: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '¡$message!',
                style: GoogleFonts.play(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
