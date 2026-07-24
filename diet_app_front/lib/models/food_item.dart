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
      id: json['id'] as int,
      name: json['name'] as String,
      calories: json['calories'] as int,
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbo: (json['carbo'] as num).toDouble(),
      salt: (json['salt'] as num).toDouble(),
    );
  }
}
