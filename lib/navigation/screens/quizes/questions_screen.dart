import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';
import 'package:wisdrive/widgets/quiz/quiz_completed.dart';
import 'package:wisdrive/widgets/quiz/answered_quiz_snackbar.dart';
import 'package:wisdrive/widgets/quiz/answer_options.dart'; // << nuevo widget

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.quizId,
    required this.quizName,
  });

  final int quizId;
  final String quizName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> questions = [];
  Map<int, List<Map<String, dynamic>>> answers = {};
  int currentIndex = 0;
  int? selectedAnswerId;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response =
        await supabase.from('questions').select().eq('quiz_id', widget.quizId);
    final List<Map<String, dynamic>> fetchedQuestions =
        List<Map<String, dynamic>>.from(response);
    setState(() {
      questions = fetchedQuestions;
    });
    for (var question in fetchedQuestions) {
      await fetchAnswers(question['id']);
    }
  }

  Future<void> fetchAnswers(int questionId) async {
    final response =
        await supabase.from('answers').select().eq('question_id', questionId);
    setState(() {
      answers[questionId] = List<Map<String, dynamic>>.from(response);
    });
  }

  void nextQuestion() {
    if (selectedAnswerId == null) return;

    final questionId = questions[currentIndex]['id'];
    final selectedAnswer = answers[questionId]
        ?.firstWhere((answer) => answer['id'] == selectedAnswerId);

    final isCorrect = selectedAnswer?['is_correct'] == true;

    AnsweredQuizSnackbar.show(context, isCorrect);

    if (isCorrect) {
      Future.delayed(const Duration(seconds: 2), () {
        if (currentIndex < questions.length - 1) {
          setState(() {
            currentIndex++;
            selectedAnswerId = null; // Limpiar selección
          });
        } else {
          Get.to(() => const QuizCompleted())!.then((result) {
            if (result == 'quiz_completed') {
              Get.back(result: 'quiz_completed');
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    if (questions.isEmpty || answers.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentIndex];
    final questionAnswers = answers[question['id']] ?? [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.quizName,
            style:
                GoogleFonts.play(color: HelperFunctions.getTextThemeColor())),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme:
            IconThemeData(color: HelperFunctions.getTextThemeColor(), size: 40),
      ),
      drawer: const SidebarMenu(),
      body: Stack(
        children: [
          Container(
            decoration: themeController.isDarkMode.value
                ? BoxDecoration(gradient: AppTheme.getInvertedGradient(true))
                : const BoxDecoration(color: AppTheme.lightBackground),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: HelperFunctions.getContainerThemeColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: (currentIndex + 1) / questions.length,
                      backgroundColor: Colors.grey[300],
                      color: AppTheme.darkPurple,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${S.of(context).question_} ${currentIndex + 1} ${S.of(context).of_} ${questions.length}",
                      style: GoogleFonts.play(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // Question container
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: AppTheme.getWhiteGradient(
                            themeController.isDarkMode.value),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          question['question_content'],
                          style: TextStyle(
                              color: HelperFunctions.getTextThemeColor(),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      // Map of four Answers
                      child: AnswerOptions(
                        answers: questionAnswers,
                        selectedId: selectedAnswerId,
                        onSelect: (id) {
                          setState(() => selectedAnswerId = id);
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // Anser Button
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkPurple,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: nextQuestion,
                        child: Text(S.of(context).answer,
                            style: GoogleFonts.play(
                                fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
