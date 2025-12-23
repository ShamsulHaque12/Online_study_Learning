class WordModel {
  final int id;
  final String word;
  final String translation;
  final String image;
  final String ttsText;
  final String audio;

  WordModel({
    required this.id,
    required this.word,
    required this.translation,
    required this.image,
    required this.ttsText,
    this.audio = "",
  });

  WordModel copyWith({
    int? id,
    String? word,
    String? translation,
    String? image,
    String? ttsText,
    String? audio,
  }) {
    return WordModel(
      id: id ?? this.id,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      image: image ?? this.image,
      ttsText: ttsText ?? this.ttsText,
      audio: audio ?? this.audio,
    );
  }
}
