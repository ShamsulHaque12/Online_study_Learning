class PointHistory {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<PointHistoryItem>? data;

  PointHistory({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory PointHistory.fromJson(Map<String, dynamic> json) {
    return PointHistory(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<PointHistoryItem>.from(
              json['data'].map(
                (x) => PointHistoryItem.fromJson(x),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class PointHistoryItem {
  final String? completedAt;
  final PointMetadata? metadata;

  PointHistoryItem({
    this.completedAt,
    this.metadata,
  });

  factory PointHistoryItem.fromJson(Map<String, dynamic> json) {
    return PointHistoryItem(
      completedAt: json['completedAt'],
      metadata: json['metadata'] != null
          ? PointMetadata.fromJson(json['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedAt': completedAt,
      'metadata': metadata?.toJson(),
    };
  }
}

class PointMetadata {
  final int? totalPoints;
  final int? timeTakenSec;
  final int? correctAnswers;
  final int? wrongAnswers;

  PointMetadata({
    this.totalPoints,
    this.timeTakenSec,
    this.correctAnswers,
    this.wrongAnswers,
  });

  factory PointMetadata.fromJson(Map<String, dynamic> json) {
    return PointMetadata(
      totalPoints: json['totalPoints'],
      timeTakenSec: json['timeTakenSec'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'timeTakenSec': timeTakenSec,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
    };
  }
}
