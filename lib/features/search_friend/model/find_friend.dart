class FindFriend {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  FindFriend({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  FindFriend.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  User? user;
  List<WeeklyProgress>? weeklyProgress;
  int? streak;
  int? vocabularyCount;
  String? chapterProgress;
  int? exp;
  String? className; // 🔥 fixed keyword issue

  Data({
    this.user,
    this.weeklyProgress,
    this.streak,
    this.vocabularyCount,
    this.chapterProgress,
    this.exp,
    this.className,
  });

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;

    if (json['weeklyProgress'] != null) {
      weeklyProgress = (json['weeklyProgress'] as List)
          .map((e) => WeeklyProgress.fromJson(e))
          .toList();
    }

    streak = json['streak'];
    vocabularyCount = json['vocabularyCount'];
    chapterProgress = json['chapterProgress'];
    exp = json['exp'];
    className = json['class'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'weeklyProgress': weeklyProgress?.map((e) => e.toJson()).toList(),
      'streak': streak,
      'vocabularyCount': vocabularyCount,
      'chapterProgress': chapterProgress,
      'exp': exp,
      'class': className,
    };
  }
}

class User {
  String? fullName;
  String? userName;
  String? image;
  String? joinedAt;
  bool? isPremium;
  bool? isFollowing;

  User({
    this.fullName,
    this.userName,
    this.image,
    this.joinedAt,
    this.isPremium,
    this.isFollowing,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    userName = json['userName'];
    image = json['image'];
    joinedAt = json['joinedAt'];
    isPremium = json['isPremium'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'image': image,
      'joinedAt': joinedAt,
      'isPremium': isPremium,
      'isFollowing': isFollowing,
    };
  }
}

class WeeklyProgress {
  String? date;
  int? xp;

  WeeklyProgress({
    this.date,
    this.xp,
  });

  WeeklyProgress.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    xp = json['xp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'xp': xp,
    };
  }
}
