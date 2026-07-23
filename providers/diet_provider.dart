import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/diet_status.dart';

// 今日の食事状況（モックデータ）を提供するプロバイダー
final dietStatusProvider = Provider<DietStatus>((ref) {
  return DietStatus(
    totalProtein: 45,
    totalFat: 85, // 目標45gに対して大幅オーバー！
    totalCarbo: 120,
    targetProtein: 100,
    targetFat: 45,
    targetCarbo: 200,
    characterMessage: "おいおい、脂質が目標の2倍近くになってるぞ。油のプールにでも飛び込んだのか？明日の体重計が楽しみだな！",
  );
});
