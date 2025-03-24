import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.quizId, required this.quizName});
  final int quizId;
  final String quizName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> questions = [];
  Map<int, List<Map<String, dynamic>>> answers = {}; // Almacena las respuestas por question_id

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await supabase
        .from('questions')
        .select()
        .eq('quiz_id', widget.quizId);

    final List<Map<String, dynamic>> fetchedQuestions = List<Map<String, dynamic>>.from(response);

    setState(() {
      questions = fetchedQuestions;
    });

    // Para cada pregunta, obtenemos sus respuestas
    for (var question in fetchedQuestions) {
      await fetchAnswers(question['id']);
    }
  }

  Future<void> fetchAnswers(int questionId) async {
    final response = await supabase
        .from('answers')
        .select()
        .eq('question_id', questionId);

    setState(() {
      answers[questionId] = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.quizName)),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final questionAnswers = answers[question['id']] ?? [];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question['question_content'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: questionAnswers.map((answer) {
                            return ListTile(
                              title: Text(answer['content']),
                              leading: const Icon(Icons.circle_outlined),
                              onTap: () {
                                bool isCorrect = answer['is_correct'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isCorrect ? '¡Correcto!' : 'Incorrecto, intenta de nuevo.'),
                                    backgroundColor: isCorrect ? Colors.green : Colors.red,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
