class FollowingModel {
  bool? success;
  int? statusCode;
  String? message;
  List<FollowingData>? data;

  FollowingModel({this.success, this.statusCode, this.message, this.data});

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<FollowingData>.from(json['data'].map((x) => FollowingData.fromJson(x)))
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

class FollowingData {
  String? id;
  String? fullName;
  String? image;
  int? totalPoints;

  FollowingData({this.id, this.fullName, this.image, this.totalPoints});

  factory FollowingData.fromJson(Map<String, dynamic> json) {
    return FollowingData(
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
