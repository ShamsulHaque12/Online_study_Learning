enum QuestionType { multipleChoice, trueFalse }

class ImageOptions {
  final int id;
  final String text;
  final String? emoji;
  final bool isCorrect;

  ImageOptions({
    required this.id,
    required this.text,
    this.emoji,
    required this.isCorrect,
  });
}

class ImageQuestion {
  final int id;
  final String question;
  final String? imageUrl;
  final String? description;
  final QuestionType type;
  final List<ImageOptions> options;

  ImageQuestion({
    required this.id,
    required this.question,
    this.imageUrl,
    this.description,
    required this.type,
    required this.options,
  });
}