class AchivementModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AchivementModel({this.success, this.statusCode, this.message, this.data});

  factory AchivementModel.fromJson(Map<String, dynamic> json) => AchivementModel(
        success: json['success'] as bool?,
        statusCode: json['statusCode'] as int?,
        message: json['message'] as String?,
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  Tabs? tabs;

  Data({this.tabs});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tabs: json['tabs'] != null ? Tabs.fromJson(json['tabs']) : null,
      );

  Map<String, dynamic> toJson() => {
        'tabs': tabs?.toJson(),
      };
}

class Tabs {
  List<BadgeTiers>? badgeTiers;
  List<LevelSystem>? levelSystem;
  List<MetaBadges>? metaBadges;

  Tabs({this.badgeTiers, this.levelSystem, this.metaBadges});

  factory Tabs.fromJson(Map<String, dynamic> json) => Tabs(
        badgeTiers: json['badgeTiers'] != null
            ? List<BadgeTiers>.from(
                json['badgeTiers'].map((x) => BadgeTiers.fromJson(x)))
            : null,
        levelSystem: json['levelSystem'] != null
            ? List<LevelSystem>.from(
                json['levelSystem'].map((x) => LevelSystem.fromJson(x)))
            : null,
        metaBadges: json['metaBadges'] != null
            ? List<MetaBadges>.from(
                json['metaBadges'].map((x) => MetaBadges.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'badgeTiers': badgeTiers?.map((x) => x.toJson()).toList(),
        'levelSystem': levelSystem?.map((x) => x.toJson()).toList(),
        'metaBadges': metaBadges?.map((x) => x.toJson()).toList(),
      };
}

class BadgeTiers {
  String? tierKey;
  String? title;
  String? ltDesc;
  String? enDesc;
  bool? unlocked;
  int? progressPercent;
  List<Badges>? badges;

  BadgeTiers(
      {this.tierKey,
      this.title,
      this.ltDesc,
      this.enDesc,
      this.unlocked,
      this.progressPercent,
      this.badges});

  factory BadgeTiers.fromJson(Map<String, dynamic> json) => BadgeTiers(
        tierKey: json['tierKey'] as String?,
        title: json['title'] as String?,
        ltDesc: json['lt_desc'] as String?,
        enDesc: json['en_desc'] as String?,
        unlocked: json['unlocked'] as bool?,
        progressPercent: json['progressPercent'] as int?,
        badges: json['badges'] != null
            ? List<Badges>.from(json['badges'].map((x) => Badges.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'tierKey': tierKey,
        'title': title,
        'lt_desc': ltDesc,
        'en_desc': enDesc,
        'unlocked': unlocked,
        'progressPercent': progressPercent,
        'badges': badges?.map((x) => x.toJson()).toList(),
      };
}

class Badges {
  String? key;
  String? title;
  bool? unlocked;
  int? progressPercent;

  Badges({this.key, this.title, this.unlocked, this.progressPercent});

  factory Badges.fromJson(Map<String, dynamic> json) => Badges(
        key: json['key'] as String?,
        title: json['title'] as String?,
        unlocked: json['unlocked'] as bool?,
        progressPercent: json['progressPercent'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'title': title,
        'unlocked': unlocked,
        'progressPercent': progressPercent,
      };
}

class MetaBadges {
  String? tierKey;
  String? title;
  String? ltDesc;
  String? enDesc;
  bool? unlocked;
  int? progressPercent;

  MetaBadges(
      {this.tierKey,
      this.title,
      this.ltDesc,
      this.enDesc,
      this.unlocked,
      this.progressPercent});

  factory MetaBadges.fromJson(Map<String, dynamic> json) => MetaBadges(
        tierKey: json['tierKey'] as String?,
        title: json['title'] as String?,
        ltDesc: json['lt_desc'] as String?,
        enDesc: json['en_desc'] as String?,
        unlocked: json['unlocked'] as bool?,
        progressPercent: json['progressPercent'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'tierKey': tierKey,
        'title': title,
        'lt_desc': ltDesc,
        'en_desc': enDesc,
        'unlocked': unlocked,
        'progressPercent': progressPercent,
      };
}

class LevelSystem {
  String? tierKey;
  String? title;
  String? ltDesc;
  String? enDesc;
  bool? unlocked;
  int? progressPercent;
  List<Badges>? badges;

  LevelSystem(
      {this.tierKey,
      this.title,
      this.ltDesc,
      this.enDesc,
      this.unlocked,
      this.progressPercent,
      this.badges});

  factory LevelSystem.fromJson(Map<String, dynamic> json) => LevelSystem(
        tierKey: json['tierKey'] as String?,
        title: json['title'] as String?,
        ltDesc: json['lt_desc'] as String?,
        enDesc: json['en_desc'] as String?,
        unlocked: json['unlocked'] as bool?,
        progressPercent: json['progressPercent'] as int?,
        badges: json['badges'] != null
            ? List<Badges>.from(json['badges'].map((x) => Badges.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'tierKey': tierKey,
        'title': title,
        'lt_desc': ltDesc,
        'en_desc': enDesc,
        'unlocked': unlocked,
        'progressPercent': progressPercent,
        'badges': badges?.map((x) => x.toJson()).toList(),
      };
}
