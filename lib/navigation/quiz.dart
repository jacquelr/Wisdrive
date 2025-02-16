import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/navigation/screens/questions_screen.dart';
import 'package:quiz_app/navigation/screens/results_screen.dart';
import 'package:quiz_app/navigation/screens/start_screen.dart';
import 'package:quiz_app/data/color_palete.dart';

const topCenter = Alignment.topCenter;
const bottomCenter = Alignment.bottomCenter;

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = []; //we can use '_selectedAnswers' to make variable private if we make public the class
  var activeScreen = 'start-screen';
  //Widget? activeScreen; // '?' Tells Dart that the variable may contain a Widget OR null

  /*@override  //Initialyze before the build method
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }*/

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(chosenAnwers: selectedAnswers, onRestart: restartQuiz,);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ //Palette colors initialyzed on color_palete.dart
                  purple,
                  blackPurple,
                ],
                begin: topCenter, //variables of Alignment
                end: bottomCenter, //variables of Alignment
              ),
            ),
            child: screenWidget),
      ),
    );
  }
}
