import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'questions_screen.dart';
import '../../../generated/l10n.dart';

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
      backgroundColor: HelperFunctions.getBlackContainerThemeColor(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: FittedBox(
            child: Text(
              '${widget.moduleName} Quiz',
              style:
                  GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: HelperFunctions.getIconThemeColor(),
            size: 50,
          )),
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
                      color: HelperFunctions.getQuizBgContainerThemeColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      // Map of Quizes inside of a Module
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              HelperFunctions.getQuizLevelContainerThemeColor(),
                          radius: 30,
                          child: Text(
                            '${S.of(context).level} ${index + 1}',
                            style: GoogleFonts.play(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AutoSizeText(
                            quiz['name'],
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
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
