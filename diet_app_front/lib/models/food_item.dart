class FoodItem {
  final int id;
  final String name;
  final int calories;
  final double protein;
  final double fat;
  final double carbo;
  final double salt;

  FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbo,
    required this.salt,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      calories: json['calories'] as int? ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      carbo: (json['carbo'] as num?)?.toDouble() ?? 0.0,
      salt: (json['salt'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
