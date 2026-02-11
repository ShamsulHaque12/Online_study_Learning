class MasteryModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final MasteryData? data;

  MasteryModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory MasteryModel.fromJson(Map<String, dynamic> json) => MasteryModel(
        success: json['success'] as bool?,
        statusCode: json['statusCode'] as int?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? MasteryData.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

class MasteryData {
  final int? overallProgressPercent;
  final String? message;
  final Chapter? chapter;
  final List<Section>? sections;

  MasteryData({
    this.overallProgressPercent,
    this.message,
    this.chapter,
    this.sections,
  });

  factory MasteryData.fromJson(Map<String, dynamic> json) => MasteryData(
        overallProgressPercent: json['overallProgressPercent'] as int?,
        message: json['message'] as String?,
        chapter: json['chapter'] != null
            ? Chapter.fromJson(json['chapter'] as Map<String, dynamic>)
            : null,
        sections: json['sections'] != null
            ? List<Section>.from(
                (json['sections'] as List)
                    .map((x) => Section.fromJson(x as Map<String, dynamic>)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        'overallProgressPercent': overallProgressPercent,
        'message': message,
        if (chapter != null) 'chapter': chapter!.toJson(),
        if (sections != null)
          'sections': sections!.map((x) => x.toJson()).toList(),
      };
}

class Chapter {
  final int? current;
  final int? progressPercent;
  final int? pointsToNextChapter;

  Chapter({this.current, this.progressPercent, this.pointsToNextChapter});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        current: json['current'] as int?,
        progressPercent: json['progressPercent'] as int?,
        pointsToNextChapter: json['pointsToNextChapter'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'current': current,
        'progressPercent': progressPercent,
        'pointsToNextChapter': pointsToNextChapter,
      };
}

class Section {
  final String? level;
  final int? totalLessons;
  final int? completedLessons;
  final int? progressPercent;

  Section({
    this.level,
    this.totalLessons,
    this.completedLessons,
    this.progressPercent,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        level: json['level'] as String?,
        totalLessons: json['totalLessons'] as int?,
        completedLessons: json['completedLessons'] as int?,
        progressPercent: json['progressPercent'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'level': level,
        'totalLessons': totalLessons,
        'completedLessons': completedLessons,
        'progressPercent': progressPercent,
      };
}
