class FlashCardModel {
  final List<Flashcards> flashcards;
  final String? language;

  FlashCardModel({List<Flashcards>? flashcards, this.language})
      : flashcards = flashcards ?? [];

  factory FlashCardModel.fromJson(Map<String, dynamic> json) {
    return FlashCardModel(
      flashcards: (json['flashcards'] as List?)
              ?.map((e) => Flashcards.fromJson(e))
              .toList() ??
          [],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() => {
        'flashcards': flashcards.map((e) => e.toJson()).toList(),
        'language': language,
      };
}

class Flashcards {
  final String? syllables;
  final String? meaning;
  final String? topicName;
  final String? subTopicName;
  final String? word;
  final String? englishMeaning;

  Flashcards({
    this.syllables,
    this.meaning,
    this.topicName,
    this.subTopicName,
    this.word,
    this.englishMeaning,
  });

  factory Flashcards.fromJson(Map<String, dynamic> json) => Flashcards(
        syllables: json['syllables'],
        meaning: json['meaning'],
        topicName: json['topic_name'],
        subTopicName: json['sub_topic_name'],
        word: json['word'],
        englishMeaning: json['english_meaning'],
      );

  Map<String, dynamic> toJson() => {
        'syllables': syllables,
        'meaning': meaning,
        'topic_name': topicName,
        'sub_topic_name': subTopicName,
        'word': word,
        'english_meaning': englishMeaning,
      };
}
