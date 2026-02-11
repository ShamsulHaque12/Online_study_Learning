class ContentModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ContentModel({this.success, this.statusCode, this.message, this.data});

  ContentModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? level;
  int? chapter;
  int? order;
  Titles? titles;
  String? createdAt;
  String? updatedAt;
  List<Contents>? contents;

  Data(
      {this.id,
        this.level,
        this.chapter,
        this.order,
        this.titles,
        this.createdAt,
        this.updatedAt,
        this.contents});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    chapter = json['chapter'];
    order = json['order'];
    titles =
    json['titles'] != null ? Titles.fromJson(json['titles']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['chapter'] = chapter;
    data['order'] = order;
    if (titles != null) {
      data['titles'] = titles!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Titles {
  String? en;

  Titles({this.en});

  Titles.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    return data;
  }
}

class Contents {
  List<WordLearning>? wordLearning;
  List<SelectedLearning>? selectedLearning;
  String? id;
  String? topicId;
  String? createdAt;
  String? updatedAt;

  Contents(
      {this.wordLearning,
        this.selectedLearning,
        this.id,
        this.topicId,
        this.createdAt,
        this.updatedAt});

  Contents.fromJson(Map<String, dynamic> json) {
    if (json['wordLearning'] != null) {
      wordLearning = <WordLearning>[];
      json['wordLearning'].forEach((v) {
        wordLearning!.add(WordLearning.fromJson(v));
      });
    }
    if (json['selectedLearning'] != null) {
      selectedLearning = <SelectedLearning>[];
      json['selectedLearning'].forEach((v) {
        selectedLearning!.add(SelectedLearning.fromJson(v));
      });
    }
    id = json['id'];
    topicId = json['topicId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wordLearning != null) {
      data['wordLearning'] = wordLearning!.map((v) => v.toJson()).toList();
    }
    if (selectedLearning != null) {
      data['selectedLearning'] =
          selectedLearning!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['topicId'] = topicId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class WordLearning {
  String? enWord;
  String? ltWord;
  String? image;

  WordLearning({this.enWord, this.ltWord, this.image});

  WordLearning.fromJson(Map<String, dynamic> json) {
    enWord = json['enWord'];
    ltWord = json['ltWord'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enWord'] = enWord;
    data['ltWord'] = ltWord;
    data['image'] = image;
    return data;
  }
}

class SelectedLearning {
  String? mainWord;
  Options? options;
  String? correctWord;

  SelectedLearning({this.mainWord, this.options, this.correctWord});

  SelectedLearning.fromJson(Map<String, dynamic> json) {
    mainWord = json['mainWord'];
    options =
    json['options'] != null ? Options.fromJson(json['options']) : null;
    correctWord = json['correctWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainWord'] = mainWord;
    if (options != null) {
      data['options'] = options!.toJson();
    }
    data['correctWord'] = correctWord;
    return data;
  }
}

class Options {
  A? a;
  A? b;
  A? c;
  A? d;

  Options({this.a, this.b, this.c, this.d});

  Options.fromJson(Map<String, dynamic> json) {
    a = json['A'] != null ? A.fromJson(json['A']) : null;
    b = json['B'] != null ? A.fromJson(json['B']) : null;
    c = json['C'] != null ? A.fromJson(json['C']) : null;
    d = json['D'] != null ? A.fromJson(json['D']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (a != null) {
      data['A'] = a!.toJson();
    }
    if (b != null) {
      data['B'] = b!.toJson();
    }
    if (c != null) {
      data['C'] = c!.toJson();
    }
    if (d != null) {
      data['D'] = d!.toJson();
    }
    return data;
  }
}

class A {
  String? word;
  String? image;

  A({this.word, this.image});

  A.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['image'] = image;
    return data;
  }
}
