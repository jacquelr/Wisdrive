import 'package:flutter/material.dart';

import 'package:wisdrive/data/questions.dart';
import 'package:wisdrive/navigation/screens/questions_screen.dart';
import 'package:wisdrive/navigation/screens/results_screen.dart';
import 'package:wisdrive/navigation/screens/start_screen.dart';
import 'package:wisdrive/data/app_theme.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  //switches first start-screen to questions-screen
  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  //push selectedAnswer into array and change to results-screen when all answers are answered
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  //emtpy selectedAnwers array and set start-screen
  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    //switch screen to questions-screen or results-screen
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnwers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      title: 'Wisdrive',
      theme: ThemeData(),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, //Elimina la sombra
          leading: IconButton(
            onPressed: () {}, //Logica para el left side menu
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
            iconSize: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {}, //Logica para el profile button
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              iconSize: 40,
            ),
          ],
        ),
        body: Container(
            decoration:
                const BoxDecoration(gradient: AppTheme.blackBgGradient),
            child: screenWidget),
      ),
    );
  }
}
