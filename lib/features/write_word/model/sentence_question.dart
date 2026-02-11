class SentenceQuestion {
  final int id;
  final String displaySentence;
  final List<String> shuffledWords;
  final List<String> correctAnswer;
  final bool isEnglishToFilipino;

  SentenceQuestion({
    required this.id,
    required this.displaySentence,
    required this.shuffledWords,
    required this.correctAnswer,
    required this.isEnglishToFilipino,
  });
}