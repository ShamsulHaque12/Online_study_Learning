class FriendsModel {
  bool? success;
  int? statusCode;
  String? message;
  List<FriendData>? data;

  FriendsModel({this.success, this.statusCode, this.message, this.data});

  factory FriendsModel.fromJson(Map<String, dynamic> json) {
    return FriendsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<FriendData>.from(
              json['data'].map((x) => FriendData.fromJson(x)))
          : [],
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

class FriendData {
  String? id;
  String? fullName;
  String? image; // Fixed type from Null? to String?
  int? totalPoints;

  FriendData({this.id, this.fullName, this.image, this.totalPoints});

  factory FriendData.fromJson(Map<String, dynamic> json) {
    return FriendData(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'], // can be null
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
