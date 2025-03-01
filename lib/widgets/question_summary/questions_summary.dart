import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/question_summary/summary_row.dart';


class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryRow(data);
            },
            ).toList(),
        ),
      ),
    );
  }
}
