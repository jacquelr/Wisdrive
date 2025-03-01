import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/widgets/question_summary/question_index.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIndex(
          questionIdex: itemData['question_index'] as int,
          isCorrect: isCorrectAnswer,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(itemData['user_answer'] as String,
                  style: TextStyle(
                    color: isCorrectAnswer ? const Color.fromARGB(197, 255, 255, 255) : const Color.fromARGB(255, 243, 52, 38), //const Color.fromARGB(255, 202, 13, 0),
                  )),
              Text(itemData['correct_answer'] as String,
                  style: const TextStyle(
                    color: Colors.green,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
