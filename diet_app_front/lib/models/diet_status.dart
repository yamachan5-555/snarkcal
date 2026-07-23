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
}
test