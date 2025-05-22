import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'questions_screen.dart';
import '../../../generated/l10n.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/service/auth_service.dart';

class QuizesScreen extends StatefulWidget {
  const QuizesScreen({
    super.key,
    required this.moduleId,
    required this.moduleName,
  });

  final int moduleId;
  final String moduleName;

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  final authService = Get.find<AuthService>();
  final supabaseService = Get.find<SupabaseService>();
  final ThemeController themeController = Get.find();
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> quizes = [];
  late String userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCurrentUserData();
  }

  Future<void> loadCurrentUserData() async {
    try {
      final user = await supabaseService.getUserProfileOrThrow();
      if (user['id'] == null) {
        return;
      }

      userId = user['id'].toString();

      await fetchQuizzes();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchQuizzes() async {
    setState(() {
      isLoading = true;
    });

    try {
      // 1. Obtener todos los quizzes del módulo
      final quizzesResponse = await supabase
          .from('quizzes')
          .select()
          .eq('module_id', widget.moduleId);

      // 2. Obtener los quizzes completados por el usuario
      final completedResponse = await supabase
          .from('completed_quizzes')
          .select('quizz_id')
          .eq('user_id', userId);

      final completedIds =
          completedResponse.map((entry) => entry['quizz_id'] as int).toSet();

      // 3. Marcar cada quiz como completado si está en el set
      final loadedQuizzes = quizzesResponse.map((quiz) {
        return {
          ...quiz,
          'completed': completedIds.contains(quiz['id']),
        };
      }).toList();

      setState(() {
        quizes = List<Map<String, dynamic>>.from(loadedQuizzes);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
            style: GoogleFonts.play(
              color: HelperFunctions.getTextThemeColor(),
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: HelperFunctions.getIconThemeColor(),
          size: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : quizes.isEmpty
                ? Center(
                    child: Text(
                      'No hay quizzes disponibles.',
                      style:
                          GoogleFonts.play(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
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
                              if (result == 'quiz_completed') {
                                fetchQuizzes();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: HelperFunctions
                                    .getQuizBgContainerThemeColor(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HelperFunctions
                                        .getQuizLevelContainerThemeColor(),
                                    radius: 30,
                                    child: Text(
                                      '${S.of(context).level} ${index + 1}',
                                      style: GoogleFonts.play(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              quiz['name'],
                                              style: GoogleFonts.play(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (quiz['completed'] == true)
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 24,
                                            ),
                                        ],
                                      ),
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
