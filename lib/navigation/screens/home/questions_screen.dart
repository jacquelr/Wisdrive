import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/navigation/screens/home/quizes_screen.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key,
      required this.quizId,
      required this.quizName,
      // required this.moduleId,
      // required this.moduleName
      });

  final int quizId;
  final String quizName;
  // final int moduleId;
  // final String moduleName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> questions = [];
  Map<int, List<Map<String, dynamic>>> answers = {};
  int currentIndex = 0;

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
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("¡Quiz terminado!"),
          content: const Text("Has respondido todas las preguntas."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                Get.back(result: 'quiz_completed');
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
          iconTheme: IconThemeData(
              color: HelperFunctions.getTextThemeColor(), size: 50),
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
                          "Pregunta ${currentIndex + 1} de ${questions.length}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: AppTheme.getGradient(
                              themeController.isDarkMode.value),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          question['question_content'],
                          style: TextStyle(
                              color: HelperFunctions.getTextThemeColor(),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: questionAnswers.map((answer) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    bool isCorrect = answer['is_correct'];
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(isCorrect
                                            ? '¡Correcto!'
                                            : 'Incorrecto, intenta de nuevo.'),
                                        backgroundColor: isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                    if (isCorrect) {
                                      Future.delayed(const Duration(seconds: 1),
                                          nextQuestion);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.lightPurple,
                                    padding: const EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    answer['content'],
                                    style: GoogleFonts.play(
                                        color:
                                            HelperFunctions.getTextThemeColor(),
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.darkPurple,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: nextQuestion,
                          child: Text("CONTESTAR",
                              style: GoogleFonts.play(
                                  fontSize: 20,
                                  color: HelperFunctions.getTextThemeColor())),
                        ),
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
