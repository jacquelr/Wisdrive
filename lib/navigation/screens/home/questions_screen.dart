import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key, required this.quizId, required this.quizName});
  final int quizId;
  final String quizName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> questions = [];
  Map<int, List<Map<String, dynamic>>> answers =
      {}; // Store answers by question_id
  int currentIndex = 0; // Current question index

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

    // Load answers to each question
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
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Finished quiz
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("¡Quiz terminado!"),
          content: const Text("Has respondido todas las preguntas."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
                Navigator.pop(context);
              },
              child: const Text("Salir"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    Color? getTextThemeColor() {
      final textColor =
          themeController.isDarkMode.value ? white : AppTheme.darkPurple;
      return textColor;
    }

    Color? getIconThemeColor() {
      final iconColor = themeController.isDarkMode.value
          ? AppTheme.lightBackground
          : AppTheme.lightSecondary;
      return iconColor;
    }

    if (questions.isEmpty || answers.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentIndex]; // Pregunta actual
    final questionAnswers = answers[question['id']] ?? [];

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            widget.quizName,
            style: GoogleFonts.play(color: getTextThemeColor()),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: getIconThemeColor(), size: 50),
        ),
        drawer: const SidebarMenu(),
        body: Stack(
          children: [
            // Background gradinent
            Container(
              decoration: themeController.isDarkMode.value
                  ? BoxDecoration(
                      gradient: AppTheme.getInvertedGradient(
                          themeController.isDarkMode.value),
                    )
                  : const BoxDecoration(color: AppTheme.lightBackground),
            ),
            // Background container
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.lightBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pregunta ${currentIndex + 1} de ${questions.length}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        question['question_content'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: questionAnswers.map((answer) {
                          return ElevatedButton(
                            onPressed: () {
                              bool isCorrect = answer['is_correct'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isCorrect
                                      ? '¡Correcto!'
                                      : 'Incorrecto, intenta de nuevo.'),
                                  backgroundColor:
                                      isCorrect ? Colors.green : Colors.red,
                                ),
                              );
                              if (isCorrect) {
                                Future.delayed(
                                    const Duration(seconds: 1), nextQuestion);
                              }
                            },
                            child: Text(answer['content']),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
