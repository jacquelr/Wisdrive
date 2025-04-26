import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/app_theme.dart';

class AnswerOptions extends StatelessWidget {
  final List<Map<String, dynamic>> answers;
  final int? selectedId;
  final Function(int) onSelect;

  const AnswerOptions({
    super.key,
    required this.answers,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: answers.map((answer) {
        final bool isSelected = answer['id'] == selectedId;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onSelect(answer['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSelected ? AppTheme.darkPurple : AppTheme.lightPurple,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                answer['content'],
                style: GoogleFonts.play(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
