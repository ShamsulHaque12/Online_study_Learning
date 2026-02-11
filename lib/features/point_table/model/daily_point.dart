class DailyPoint {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<DailyPointData>? data;

  DailyPoint({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory DailyPoint.fromJson(Map<String, dynamic> json) {
    return DailyPoint(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<DailyPointData>.from(
              json['data'].map((x) => DailyPointData.fromJson(x)),
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

class DailyPointData {
  final String? date;
  final int? points;

  DailyPointData({
    this.date,
    this.points,
  });

  factory DailyPointData.fromJson(Map<String, dynamic> json) {
    return DailyPointData(
      date: json['date'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'points': points,
    };
  }
}
