import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const startScreenImage = '../assets/images/quiz-logo.png';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //MenuBar(),
          Image.asset(
            startScreenImage,
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          /*Opacity(
            opacity: 0.6,
            child: Image.asset(
              startScreenImage,
              width: 300,
            ),
          ),*/
          const SizedBox(height: 80),
          Text(
            'WISDRIVE',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Wise Way to Learn',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(171, 255, 255, 255),
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: startQuiz, //Called an Function object
            /*onPressed: () { no need to create an anonymous function if startQuiz type is Function
              startQuiz();
            },*/
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Go to Quiz'),
          ),
        ],
      ),
    );
  }
}
