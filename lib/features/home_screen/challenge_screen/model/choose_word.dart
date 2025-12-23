class QuizModel {
  final int correctIndex;
  final List<OptionModel> options;

  QuizModel({
    required this.correctIndex,
    required this.options,
  });
}

class OptionModel {
  final String title;
  final String image;

  OptionModel({
    required this.title,
    required this.image,
  });
}
