import 'package:flutter/material.dart';

import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/navigation/screens/questions_screen.dart';
import 'package:quiz_app/navigation/screens/results_screen.dart';
import 'package:quiz_app/navigation/screens/start_screen.dart';
import 'package:quiz_app/data/app_theme.dart';

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
  //Widget? activeScreen; // '?' Tells Dart that the variable may contain a Widget OR null

  /*@override  //Initialyze before the build method
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }*/

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
      //theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          //backgroundColor: ,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_balance),
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //Palette colors initialyzed on color_palete.dart
                  purple,
                  blackPurple,
                ],
                begin: Alignment.topCenter, //variables of Alignment
                end: Alignment.bottomCenter,
              ),
            ),
            child: screenWidget),
      ),
    );
  }
}
