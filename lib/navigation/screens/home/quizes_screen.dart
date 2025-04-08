import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'questions_screen.dart';

class QuizesScreen extends StatefulWidget {
  const QuizesScreen(
      {super.key, required this.moduleId, required this.moduleName});
  final int moduleId;
  final String moduleName;

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  final ThemeController themeController = Get.find();
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> quizes = [];

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    final response = await supabase
        .from('quizzes')
        .select()
        .eq('module_id', widget.moduleId);
    setState(() {
      quizes = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.moduleName} Quiz',
          style: GoogleFonts.play(color: white),
        ),
        centerTitle: true,
        iconTheme: themeController.isDarkMode.value
            ? const IconThemeData(color: AppTheme.lightBackground, size: 40)
            : const IconThemeData(color: AppTheme.lightSecondary, size: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: quizes.length,
          itemBuilder: (context, index) {
            final quiz = quizes[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await Get.to(() => QuestionsScreen(
                      quizId: quiz['id'],
                      quizName: quiz['name'],
                    ));
                    if (result != 'quiz_completed') {
                      fetchQuizzes();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.mediumPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.lightSecondary,
                          radius: 30,
                          child: Text(
                            'Nivel ${index + 1}',
                            style: GoogleFonts.play(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          quiz['name'],
                          style: GoogleFonts.play(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
