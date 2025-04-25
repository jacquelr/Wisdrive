import 'package:supabase_flutter/supabase_flutter.dart';

class QuizService {
  final SupabaseClient supabase = Supabase.instance.client;
  final String tableName = 'quizzes';


  // Future<void> fetchQuizzes() async {
  //   final response = await supabase.from('quizzes').select();
  //   print(response); // Para ver qué devuelve la consulta
  //   setState(() {
  //     quizzes = response as List<Map<String, dynamic>>;
  //   });
  // }

  Future<void> addQuiz(String name, int moduleId) async {
    await supabase
        .from('quizzes')
        .insert({'quiz_name': name, 'module_id': moduleId});
    // fetchQuizzes();
  }

  Future<void> updateQuiz(int id, String name) async {
    await supabase
        .from('quizzes')
        .update({'quiz_name': name}).match({'quiz_id': id});
    // fetchQuizzes();
  }

  Future<void> deleteQuiz(int id) async {
    await supabase.from('quizzes').delete().match({'quiz_id': id});
    // fetchQuizzes();
  }
}
