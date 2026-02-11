class RolePlayResponseModel {
  final String? scenario;
  final String? questionInLanguage;
  final String? questionEnglish;
  final String? language;

  RolePlayResponseModel({
    this.scenario,
    this.questionInLanguage,
    this.questionEnglish,
    this.language,
  });

  factory RolePlayResponseModel.fromJson(Map<String, dynamic> json) {
    return RolePlayResponseModel(
      scenario: json['scenario'],
      questionInLanguage: json['question_in_language'],
      questionEnglish: json['question_english'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scenario': scenario,
      'question_in_language': questionInLanguage,
      'question_english': questionEnglish,
      'language': language,
    };
  }
}
