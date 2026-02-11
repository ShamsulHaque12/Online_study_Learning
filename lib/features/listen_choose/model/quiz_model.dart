class QuizModel {
  final int id;
  final String audioText;
  final List<AnswerOption> options;

  QuizModel({
    required this.id,
    required this.audioText,
    required this.options,
  });
}

class AnswerOption {
  final String text;
  final bool isCorrect;

  AnswerOption({
    required this.text,
    required this.isCorrect,
  });
}