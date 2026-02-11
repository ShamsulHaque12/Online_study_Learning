class RoleCorrectionModel {
  final bool? needsImprovement;
  final String? original;
  final String? better;

  RoleCorrectionModel({
    this.needsImprovement,
    this.original,
    this.better,
  });

  factory RoleCorrectionModel.fromJson(Map<String, dynamic> json) {
    return RoleCorrectionModel(
      needsImprovement: json['needs_improvement'],
      original: json['original'],
      better: json['better'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'needs_improvement': needsImprovement,
      'original': original,
      'better': better,
    };
  }
}
