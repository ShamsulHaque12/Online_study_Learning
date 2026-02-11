class PointSummary {
  final bool? success;
  final int? statusCode;
  final String? message;
  final PointData? data;

  PointSummary({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory PointSummary.fromJson(Map<String, dynamic> json) {
    return PointSummary(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? PointData.fromJson(json['data'])
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

class PointData {
  final int? totalPoints;
  final int? totalTime;
  final WeeklySummary? thisWeek;

  PointData({
    this.totalPoints,
    this.totalTime,
    this.thisWeek,
  });

  factory PointData.fromJson(Map<String, dynamic> json) {
    return PointData(
      totalPoints: json['totalPoints'],
      totalTime: json['totalTime'],
      thisWeek: json['thisWeek'] != null
          ? WeeklySummary.fromJson(json['thisWeek'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'totalTime': totalTime,
      'thisWeek': thisWeek?.toJson(),
    };
  }
}

class WeeklySummary {
  final int? points;
  final int? time;

  WeeklySummary({
    this.points,
    this.time,
  });

  factory WeeklySummary.fromJson(Map<String, dynamic> json) {
    return WeeklySummary(
      points: json['points'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'time': time,
    };
  }
}
