import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> quizzes = [];

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
  final response = await supabase.from('quizzes').select();
  print(response); // Para ver qué devuelve la consulta
  setState(() {
    quizzes = response as List<Map<String, dynamic>>;
  });
}


  Future<void> addQuiz(String name, int moduleId) async {
    await supabase.from('quizzes').insert({'quiz_name': name, 'module_id': moduleId});
    fetchQuizzes();
  }

  Future<void> updateQuiz(int id, String name) async {
    await supabase.from('quizzes').update({'quiz_name': name}).match({'quiz_id': id});
    fetchQuizzes();
  }

  Future<void> deleteQuiz(int id) async {
    await supabase.from('quizzes').delete().match({'quiz_id': id});
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
            title: Text(quiz['quiz_name']),
            subtitle: Text('Module ID: ${quiz['module_id']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => updateQuiz(quiz['quiz_id'], 'Nuevo Nombre'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteQuiz(quiz['quiz_id']),
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
