class ListeningDialogueModel {
  final String? conversationId;
  final String? topic;
  final List<ListeningQuestion>? questions;

  ListeningDialogueModel({
    this.conversationId,
    this.topic,
    this.questions,
  });

  factory ListeningDialogueModel.fromJson(Map<String, dynamic> json) {
    return ListeningDialogueModel(
      conversationId: json['conversation_id'],
      topic: json['topic'],
      questions: json['questions'] != null
          ? (json['questions'] as List)
              .map((e) => ListeningQuestion.fromJson(e))
              .toList()
          : [],
    );
  }
}

class ListeningQuestion {
  final String? question;
  final List<ListeningOption>? options;
  final int? correctOptionIndex;

  ListeningQuestion({
    this.question,
    this.options,
    this.correctOptionIndex,
  });

  factory ListeningQuestion.fromJson(Map<String, dynamic> json) {
    return ListeningQuestion(
      question: json['question'],
      options: json['options'] != null
          ? (json['options'] as List)
              .map((e) => ListeningOption.fromJson(e))
              .toList()
          : [],
      correctOptionIndex: json['correct_option_index'],
    );
  }
}

class ListeningOption {
  final String? text;

  ListeningOption({this.text});

  factory ListeningOption.fromJson(Map<String, dynamic> json) {
    return ListeningOption(
      text: json['text'],
    );
  }
}
