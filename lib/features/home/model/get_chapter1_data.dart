class GetChapter1Model {
  final bool success;
  final int statusCode;
  final String message;
  final List<ChapterData> data;

  GetChapter1Model({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetChapter1Model.fromJson(Map<String, dynamic> json) {
    return GetChapter1Model(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ChapterData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class ChapterData {
  final String id;
  final String level;
  final int chapter;
  final int order;
  final ChapterTitles titles;
  final String createdAt;
  final String updatedAt;

  ChapterData({
    required this.id,
    required this.level,
    required this.chapter,
    required this.order,
    required this.titles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) {
    return ChapterData(
      id: json['id'] ?? '',
      level: json['level'] ?? '',
      chapter: json['chapter'] is int
          ? json['chapter']
          : int.tryParse(json['chapter']?.toString() ?? '0') ?? 0,
      order: json['order'] is int
          ? json['order']
          : int.tryParse(json['order']?.toString() ?? '0') ?? 0,
      titles: ChapterTitles.fromJson(json['titles'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level,
        'chapter': chapter,
        'order': order,
        'titles': titles.toJson(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class ChapterTitles {
  final String en;

  ChapterTitles({required this.en});

  factory ChapterTitles.fromJson(Map<String, dynamic> json) {
    return ChapterTitles(
      en: json['en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'en': en,
      };
}
