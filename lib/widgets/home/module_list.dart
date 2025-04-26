import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/quizes/quizes_screen.dart';

class ModuleList extends StatelessWidget {
  final int selectedCategoryId;

  const ModuleList({super.key, required this.selectedCategoryId});

  Future<List<Map<String, dynamic>>> fetchModules() async {
    final supabase = Supabase.instance.client;
    return await supabase
        .from('modules')
        .select()
        .eq('category_id', selectedCategoryId);
  }

  // Simulation of progress of completed quizes
  double getProgress(int moduleId) {
    return (moduleId % 10) / 10.0; // fake data example based on id
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchModules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(S.of(context).no_modules_available));
        }

        final modules = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // columns
              crossAxisSpacing: 10, // y gap
              mainAxisSpacing: 10, //x gap
              
            ),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              final progress = getProgress(module['id']);

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuizesScreen(
                      moduleId: module['id'],
                      moduleName: module['module_name'],
                    ),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.getInvertedGradient(
                        themeController.isDarkMode.value),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${S.of(context).lesson} ${module['id']}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.question_mark,
                          size: 75,
                          color: Colors.white,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 18,
                            child: FittedBox(
                              child: Text(
                                module['module_name'] ?? S.of(context).unnamed,
                                style: GoogleFonts.play(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: AppTheme.darkPurple,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.lightSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
