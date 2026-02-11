class FollowerModel {
  bool? success;
  int? statusCode;
  String? message;
  List<FollowerData>? data;

  FollowerModel({this.success, this.statusCode, this.message, this.data});

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<FollowerData>.from(json['data'].map((x) => FollowerData.fromJson(x)))
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

class FollowerData {
  String? id;
  String? fullName;
  String? image;
  int? totalPoints;

  FollowerData({this.id, this.fullName, this.image, this.totalPoints});

  factory FollowerData.fromJson(Map<String, dynamic> json) {
    return FollowerData(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
      totalPoints: json['totalPoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'image': image,
      'totalPoints': totalPoints,
    };
  }
}
