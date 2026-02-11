class CameraModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final CameraData? data;

  CameraModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CameraModel.fromJson(Map<String, dynamic> json) {
    return CameraModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? CameraData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CameraData {
  final String? word;
  final String? syllables;
  final List<String>? meanings;
  final String? englishSentence;
  final String? sentenceInLanguage;
  final String? language;

  CameraData({
    this.word,
    this.syllables,
    this.meanings,
    this.englishSentence,
    this.sentenceInLanguage,
    this.language,
  });

  factory CameraData.fromJson(Map<String, dynamic> json) {
    return CameraData(
      word: json['word'],
      syllables: json['syllables'],
      meanings: json['meanings'] != null
          ? List<String>.from(json['meanings'])
          : [],
      englishSentence: json['english_sentence'],
      sentenceInLanguage: json['sentence_in_language'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'syllables': syllables,
      'meanings': meanings,
      'english_sentence': englishSentence,
      'sentence_in_language': sentenceInLanguage,
      'language': language,
    };
  }
}
