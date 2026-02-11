class GetUserModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final UserData? data;

  GetUserModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      success: json['success'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UserData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data?.toJson(),
      };
}

class UserData {
  final String? id;
  final String? fullName;
  final String? location;
  final String? levelOfFluncy; // keeping API key as-is
  final String? userName;
  final String? email;
  final String? phone;
  final bool? isPhoneVerified;
  final String? password;
  final int? profileView;
  final String? image;
  final String? gender;
  final String? preferedLanguage; // keeping API key as-is
  final String? nativeLanguage;
  final String? reasonToLearn;
  final int? howMuchTimeCanYouGive;
  final List<String>? aspectOfLearning;
  final List<String>? whichDayWantReminder;
  final String? startFrom;
  final bool? isEmailVerified;
  final bool? isVerified;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? passwordChangedAt;
  final String? bio;
  final String? dob;
  final String? bloodGroup;
  final String? fcmToken;
  final bool? isDeleted;
  final int? totalPoints;
  final int? totalPoint;
  final int? streak;

  UserData({
    this.id,
    this.fullName,
    this.location,
    this.levelOfFluncy,
    this.userName,
    this.email,
    this.phone,
    this.isPhoneVerified,
    this.password,
    this.profileView,
    this.image,
    this.gender,
    this.preferedLanguage,
    this.nativeLanguage,
    this.reasonToLearn,
    this.howMuchTimeCanYouGive,
    this.aspectOfLearning,
    this.whichDayWantReminder,
    this.startFrom,
    this.isEmailVerified,
    this.isVerified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.passwordChangedAt,
    this.bio,
    this.dob,
    this.bloodGroup,
    this.fcmToken,
    this.isDeleted,
    this.totalPoints,
    this.totalPoint,
    this.streak,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      location: json['location'] as String?,
      levelOfFluncy: json['levelOfFluncy'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      password: json['password'] as String?,
      profileView: json['profileView'] as int?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      preferedLanguage: json['preferedLanguage'] as String?,
      nativeLanguage: json['nativeLanguage'] as String?,
      reasonToLearn: json['reasonToLearn'] as String?,
      howMuchTimeCanYouGive: json['howMuchTimeCanYouGive'] as int?,
      aspectOfLearning:
          (json['aspectOfLearning'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      whichDayWantReminder:
          (json['whichDayWantReminder'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      startFrom: json['startFrom'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isVerified: json['isVerified'] as bool?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      passwordChangedAt: json['passwordChangedAt'] as String?,
      bio: json['bio'] as String?,
      dob: json['dob'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      fcmToken: json['fcmToken'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      totalPoints: json['totalPoints'] as int?,
      totalPoint: json['totalPoint'] as int?,
      streak: json['streak'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'location': location,
        'levelOfFluncy': levelOfFluncy,
        'userName': userName,
        'email': email,
        'phone': phone,
        'isPhoneVerified': isPhoneVerified,
        'password': password,
        'profileView': profileView,
        'image': image,
        'gender': gender,
        'preferedLanguage': preferedLanguage,
        'nativeLanguage': nativeLanguage,
        'reasonToLearn': reasonToLearn,
        'howMuchTimeCanYouGive': howMuchTimeCanYouGive,
        'aspectOfLearning': aspectOfLearning,
        'whichDayWantReminder': whichDayWantReminder,
        'startFrom': startFrom,
        'isEmailVerified': isEmailVerified,
        'isVerified': isVerified,
        'role': role,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'status': status,
        'passwordChangedAt': passwordChangedAt,
        'bio': bio,
        'dob': dob,
        'bloodGroup': bloodGroup,
        'fcmToken': fcmToken,
        'isDeleted': isDeleted,
        'totalPoints': totalPoints,
        'totalPoint': totalPoint,
        'streak': streak,
      };
}
