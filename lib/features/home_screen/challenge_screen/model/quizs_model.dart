class QuizsModel {
  final String question;
  final String icon;
  final String correctAnswer;
  final List<String> options;
  final String audioText;

  QuizsModel({
    required this.question,
    required this.icon,
    required this.correctAnswer,
    required this.options,
    required this.audioText,
  });
}