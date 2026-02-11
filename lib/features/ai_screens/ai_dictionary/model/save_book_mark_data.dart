class SaveBookMarkData {
  bool? success;
  int? statusCode;
  String? message;
  List<BookmarkData>? data;

  SaveBookMarkData({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory SaveBookMarkData.fromJson(Map<String, dynamic> json) {
    return SaveBookMarkData(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<BookmarkData>.from(
              json['data'].map((x) => BookmarkData.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class BookmarkData {
  String? id;
  String? userId;
  String? word;
  String? syllables;
  List<String>? meanings;
  String? englishSentence;
  String? sentenceInLanguage;
  String? language;
  String? createdAt;
  String? updatedAt;

  BookmarkData({
    this.id,
    this.userId,
    this.word,
    this.syllables,
    this.meanings,
    this.englishSentence,
    this.sentenceInLanguage,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  factory BookmarkData.fromJson(Map<String, dynamic> json) {
    return BookmarkData(
      id: json['id'],
      userId: json['userId'],
      word: json['word'],
      syllables: json['syllables'],
      meanings: json['meanings'] != null
          ? List<String>.from(json['meanings'])
          : [],
      englishSentence: json['english_sentence'],
      sentenceInLanguage: json['sentence_in_language'],
      language: json['language'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'word': word,
        'syllables': syllables,
        'meanings': meanings,
        'english_sentence': englishSentence,
        'sentence_in_language': sentenceInLanguage,
        'language': language,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
