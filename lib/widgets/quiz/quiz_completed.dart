import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'dart:async';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/generated/l10n.dart';

class QuizCompleted extends StatefulWidget {
  const QuizCompleted({super.key});

  @override
  State<QuizCompleted> createState() => _QuizCompletedState();
}

class _QuizCompletedState extends State<QuizCompleted> {
  bool showConfetti = true;
  final player = AudioPlayer();

  void playSound() async {
    await player.play(AssetSource(RAutoPlayer.trumpets));
  }

  @override
  void initState() {
    super.initState();
    playSound();
    // Hide conffeti
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showConfetti = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double circleSize = screenWidth * 0.8;

    return Scaffold(
      backgroundColor: HelperFunctions.getQuizCompletedContainerThemeColor(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (showConfetti)
              Positioned.fill(
                child: Lottie.asset(
                  LottieAnimations.confeti,
                  fit: BoxFit.cover,
                  repeat: false,
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '¡${S.of(context).congratulations}!',
                    style: GoogleFonts.play(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: HelperFunctions.getTextThemeColor(),
                    ),
                  ),
                ),
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: HelperFunctions.getContainerThemeColor(),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    LottieAnimations.checkMark,
                    width: screenWidth,
                    height: screenHeight,
                    repeat: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 32.0),
                  child: Text(
                    S.of(context).finished_quiz,
                    style: GoogleFonts.play(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: HelperFunctions.getTextThemeColor(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HelperFunctions.getContainerThemeColor(),
                    foregroundColor: HelperFunctions.getWhiteBgTextThemeColor(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Get.back(result: 'quiz_completed');
                  },
                  child: FittedBox(
                    child: Text(
                      S.of(context).continue_learning,
                      style: GoogleFonts.play(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
