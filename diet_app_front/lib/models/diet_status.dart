class DietStatus {
  final int totalProtein;
  final int totalFat;
  final int totalCarbo;
  final int targetProtein;
  final int targetFat;
  final int targetCarbo;
  final String characterMessage;

  DietStatus({
    required this.totalProtein,
    required this.totalFat,
    required this.totalCarbo,
    required this.targetProtein,
    required this.targetFat,
    required this.targetCarbo,
    required this.characterMessage,
  });

  // JsonマップからDietStatusオブジェクトを生成する
  factory DietStatus.fromJson(Map<String, dynamic> json) {
    return DietStatus(
      totalProtein: json['totalProtein'] as int? ?? 0,
      totalFat: json['totalFat'] as int? ?? 0,
      totalCarbo: json['totalCarbo'] as int? ?? 0,
      targetProtein: json['targetProtein'] as int? ?? 0,
      targetFat: json['targetFat'] as int? ?? 0,
      targetCarbo: json['targetCarbo'] as int? ?? 0,
      characterMessage: json['characterMessage'] as String? ?? '',
    );
  }
}
