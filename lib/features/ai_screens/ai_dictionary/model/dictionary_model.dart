class DictionaryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  DictionaryModel({this.success, this.statusCode, this.message, this.data});

  DictionaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? word;
  String? syllables;
  List<String>? meanings;
  String? englishSentence;
  String? sentenceInLanguage;
  String? language;

  Data(
      {this.word,
      this.syllables,
      this.meanings,
      this.englishSentence,
      this.sentenceInLanguage,
      this.language});

  Data.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    syllables = json['syllables'];
    meanings = json['meanings'].cast<String>();
    englishSentence = json['english_sentence'];
    sentenceInLanguage = json['sentence_in_language'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['syllables'] = syllables;
    data['meanings'] = meanings;
    data['english_sentence'] = englishSentence;
    data['sentence_in_language'] = sentenceInLanguage;
    data['language'] = language;
    return data;
  }
}
