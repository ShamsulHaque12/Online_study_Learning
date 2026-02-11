class PercentageData {
  final bool success;
  final int statusCode;
  final String message;
  final Data? data;

  PercentageData({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PercentageData.fromJson(Map<String, dynamic> json) {
    return PercentageData(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  final int chapter;
  final int totalTopics;
  final int completedTopics;
  final int percentage;

  Data({
    required this.chapter,
    required this.totalTopics,
    required this.completedTopics,
    required this.percentage,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      chapter: json['chapter'] ?? 0,
      totalTopics: json['totalTopics'] ?? 0,
      completedTopics: json['completedTopics'] ?? 0,
      percentage: json['percentage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'chapter': chapter,
        'totalTopics': totalTopics,
        'completedTopics': completedTopics,
        'percentage': percentage,
      };
}
