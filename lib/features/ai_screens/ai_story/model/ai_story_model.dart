class AiStoryModel {
  final String? topic;
  final String? storyTargetLanguage;
  final String? storyEnglish;
  final String? language;

  AiStoryModel({
    this.topic,
    this.storyTargetLanguage,
    this.storyEnglish,
    this.language,
  });

  factory AiStoryModel.fromJson(Map<String, dynamic> json) {
    return AiStoryModel(
      topic: json['topic'],
      storyTargetLanguage: json['story_target_language'],
      storyEnglish: json['story_english'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'story_target_language': storyTargetLanguage,
        'story_english': storyEnglish,
        'language': language,
      };
}
