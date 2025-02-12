class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers); //Create a copy of answers list, storing memeory with final
    shuffledList.shuffle(); //We shuffle the copy of the stored memory of the list
    return shuffledList;
  }
}