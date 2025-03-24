import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizesScreen extends StatefulWidget {
  const QuizesScreen({super.key, required this.moduleId});
  final int moduleId;

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> quizzes = [];

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
      quizzes = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> addQuiz(String name, int moduleId) async {
    await supabase
        .from('quizzes')
        .insert({'name': name, 'module_id': moduleId});
    fetchQuizzes();
  }

  Future<void> updateQuiz(int id, String name) async {
    await supabase.from('quizzes').update({'name': name}).match({'id': id});
    fetchQuizzes();
  }

  Future<void> deleteQuiz(int id) async {
    await supabase.from('quizzes').delete().match({'id': id});
    fetchQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quizzes CRUD')),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return ListTile(
            title: Text(quiz['name']),
            subtitle: Text('Module ID: ${quiz['id']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => updateQuiz(quiz['id'], 'Nuevo Nombre'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteQuiz(quiz['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addQuiz('Nuevo Quiz', 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
