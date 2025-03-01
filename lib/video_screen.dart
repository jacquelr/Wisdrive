import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:quiz_app/answer_botton.dart';
import 'package:quiz_app/data/color_palete.dart';
import 'package:quiz_app/data/questions.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<VideoScreen> createState() {
    return _VideoScreenState();
  }
}

class _VideoScreenState extends State<VideoScreen> {
  var currentQuestionIndex = 0;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    // En este ejemplo uso la URL de YouTube que indicaste:
    final videoUrl = 'https://www.youtube.com/watch?v=ybuJ_nIXwGE';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // Pausar y eliminar el controlador para evitar fugas de memoria
    _youtubeController.pause();
    _youtubeController.dispose();
    super.dispose();
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(50, 30),
            topRight: Radius.elliptical(50, 30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contenedor del título de la pregunta
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    blackPurple,
                    royalPurple,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                currentQuestion.text,
                style: GoogleFonts.poppins(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Reproductor de YouTube
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: YoutubePlayer(
                  controller: _youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: purple,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botones de respuesta
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            }),

            const SizedBox(height: 50),

            // Botón "CONTESTAR"
            ElevatedButton(
              onPressed: () {
                // Aquí podrías manejar la lógica de "contestar"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                padding: const EdgeInsets.all(10),
              ),
              child: Text(
                'CONTESTAR',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: white,
                  fontSize: 24,
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
