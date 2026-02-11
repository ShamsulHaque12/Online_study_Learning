class QuizOption {
  final int id;
  final String text;
  final String emoji;
  final bool isCorrect;

  QuizOption({
    required this.id,
    required this.text,
    required this.emoji,
    required this.isCorrect,
  });
}

class QuizQuestion {
  final int id;
  final String question;
  final String audioText;
  final List<QuizOption> options;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.audioText,
    required this.options,
  });
}