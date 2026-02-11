class AiDialogueModel {
  final String scenario;
  final List<DialogueQuestion> questions;

  AiDialogueModel({
    required this.scenario,
    required this.questions,
  });

  factory AiDialogueModel.fromJson(Map<String, dynamic> json) {
    return AiDialogueModel(
      scenario: json['scenario'],
      questions: (json['questions'] as List)
          .map((e) => DialogueQuestion.fromJson(e))
          .toList(),
    );
  }
}

class DialogueQuestion {
  final String tagalog;
  final String english;
  final List<DialogueOption> options;
  final int correctIndex;

  DialogueQuestion({
    required this.tagalog,
    required this.english,
    required this.options,
    required this.correctIndex,
  });

  factory DialogueQuestion.fromJson(Map<String, dynamic> json) {
    return DialogueQuestion(
      tagalog: json['question'],
      english: json['question_english'],
      correctIndex: json['correct_option_index'],
      options: (json['options'] as List)
          .map((e) => DialogueOption.fromJson(e))
          .toList(),
    );
  }
}

class DialogueOption {
  final String tagalog;
  final String english;

  DialogueOption({
    required this.tagalog,
    required this.english,
  });

  factory DialogueOption.fromJson(Map<String, dynamic> json) {
    return DialogueOption(
      tagalog: json['text'],
      english: json['english_text'],
    );
  }
}
