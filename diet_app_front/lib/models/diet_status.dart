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
      totalProtein: json['totalProtein'] as int,
      totalFat: json['totalFat'] as int,
      totalCarbo: json['totalCarbo'] as int,
      targetProtein: json['targetProtein'] as int,
      targetFat: json['targetFat'] as int,
      targetCarbo: json['targetCarbo'] as int,
      characterMessage: json['characterMessage'] as String,
    );
  }
}
