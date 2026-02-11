enum QuestionType {
  multipleChoice, // 4 options (4 screens)
  wordBank,       // 8 word options (8 screens)
}

class ListenModel {
  final int id;
  final String audioText;
  final String displayText;
  final QuestionType questionType;
  final List<AnswerOption>? options; // For multiple choice
  final List<WordOption>? wordBank;  // For word bank
  final String correctAnswer;        // For word bank validation

  ListenModel({
    required this.id,
    required this.audioText,
    required this.displayText,
    required this.questionType,
    this.options,
    this.wordBank,
    this.correctAnswer = '',
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

class WordOption {
  final String word;
  final bool isSelected;

  WordOption({
    required this.word,
    this.isSelected = false,
  });
}