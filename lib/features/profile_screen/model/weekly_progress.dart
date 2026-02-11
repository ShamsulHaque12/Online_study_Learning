class WeeklyProgress {
  bool success;
  int statusCode;
  String message;
  List<DailyPointData> data;

  WeeklyProgress({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory WeeklyProgress.fromJson(Map<String, dynamic> json) {
    return WeeklyProgress(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => DailyPointData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class DailyPointData {
  String date;
  int points;

  DailyPointData({
    required this.date,
    required this.points,
  });

  factory DailyPointData.fromJson(Map<String, dynamic> json) {
    return DailyPointData(
      date: json['date'] ?? '',
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'points': points,
    };
  }
}
