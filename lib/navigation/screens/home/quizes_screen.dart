import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'questions_screen.dart'; // Importa la nueva pantalla

class QuizesScreen extends StatefulWidget {
  const QuizesScreen({super.key, required this.moduleId, required this.moduleName});
  final int moduleId;
  final String moduleName;

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
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
      appBar: AppBar(title: Text('${widget.moduleName} Quiz')),
      body: ListView.builder(
        itemCount: quizes.length,
        itemBuilder: (context, index) {
          final quiz = quizes[index];
          return ListTile(
            title: Text(quiz['name']),
            subtitle: Text('Quiz ID: ${quiz['id']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionsScreen(
                    quizId: quiz['id'],
                    quizName: quiz['name'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
