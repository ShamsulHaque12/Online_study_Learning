class SteckModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final SteckData? data;

  SteckModel({this.success, this.statusCode, this.message, this.data});

  factory SteckModel.fromJson(Map<String, dynamic> json) {
    return SteckModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? SteckData.fromJson(json['data']) : null,
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

class SteckData {
  final int? currentStreak;
  final int? longestStreak;
  final String? lastActivityDate;
  final int? target;
  final int? progressPercent;
  final SteckCalendar? calendar;

  SteckData({
    this.currentStreak,
    this.longestStreak,
    this.lastActivityDate,
    this.target,
    this.progressPercent,
    this.calendar,
  });

  factory SteckData.fromJson(Map<String, dynamic> json) {
    return SteckData(
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      lastActivityDate: json['lastActivityDate'],
      target: json['target'],
      progressPercent: json['progressPercent'],
      calendar: json['calendar'] != null
          ? SteckCalendar.fromJson(json['calendar'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivityDate': lastActivityDate,
      'target': target,
      'progressPercent': progressPercent,
      'calendar': calendar?.toJson(),
    };
  }
}

class SteckCalendar {
  final int? month;
  final int? year;
  final List<int>? activeDays;
  final int? today;

  SteckCalendar({this.month, this.year, this.activeDays, this.today});

  factory SteckCalendar.fromJson(Map<String, dynamic> json) {
    return SteckCalendar(
      month: json['month'],
      year: json['year'],
      activeDays: json['activeDays'] != null
          ? List<int>.from(json['activeDays'])
          : [],
      today: json['today'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'activeDays': activeDays,
      'today': today,
    };
  }
}
