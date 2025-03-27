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
  int currentIndex = 0; // Índice de la pregunta actual

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

    // Load answers to each question
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

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Finished quiz
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("¡Quiz terminado!"),
          content: const Text("Has respondido todas las preguntas."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                Navigator.pop(context); // Regresa a la pantalla anterior
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
    if (questions.isEmpty || answers.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentIndex]; // Pregunta actual
    final questionAnswers = answers[question['id']] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.quizName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pregunta ${currentIndex + 1} de ${questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              question['question_content'],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Column(
              children: questionAnswers.map((answer) {
                return ElevatedButton(
                  onPressed: () {
                    bool isCorrect = answer['is_correct'];
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isCorrect ? '¡Correcto!' : 'Incorrecto, intenta de nuevo.'),
                        backgroundColor: isCorrect ? Colors.green : Colors.red,
                      ),
                    );
                    if (isCorrect) {
                      Future.delayed(const Duration(seconds: 1), nextQuestion);
                    }
                  },
                  child: Text(answer['content']),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
