import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/data/questions.dart';
import 'package:wisdrive/widgets/question_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnwers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnwers;

  List<Map<String, Object>> getSummaryData() { //we can use keyword 'get summaryData {}'
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnwers.length; i++) {
      summary.add({
        'question_index': i + 1,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnwers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer']) 
        .length; //we can use arrow functions instead of annonymous functions when there is just one declaration of return

    return SizedBox(
      //SizedBox is used as a Center Widget
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions of $numTotalQuestions answers correctly',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            QuestionsSummary(summaryData),
            const SizedBox(height: 60),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
