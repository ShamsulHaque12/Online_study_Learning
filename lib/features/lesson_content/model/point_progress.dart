class PointProgress {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  PointProgress({this.success, this.statusCode, this.message, this.data});

  factory PointProgress.fromJson(Map<String, dynamic> json) {
    return PointProgress(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class Data {
  String? id;
  String? userId;
  String? moduleType;
  String? referenceId;
  String? status;
  Metadata? metadata;
  String? completedAt;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.userId,
    this.moduleType,
    this.referenceId,
    this.status,
    this.metadata,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['userId'],
      moduleType: json['moduleType'],
      referenceId: json['referenceId'],
      status: json['status'],
      metadata:
          json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
      completedAt: json['completedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'moduleType': moduleType,
      'referenceId': referenceId,
      'status': status,
      'metadata': metadata?.toJson(),
      'completedAt': completedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Metadata {
  int? totalPoints;
  int? timeTakenSec;
  int? correctAnswers;
  int? wrongAnswers;

  Metadata({
    this.totalPoints,
    this.timeTakenSec,
    this.correctAnswers,
    this.wrongAnswers,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
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
