import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/diet_status.dart';

// 状態を管理する・更新するNotifierクラス
class DietNotifier extends Notifier<DietStatus> {
  @override
  DietStatus build() {
    // 初期状態のデータ（モック）
    return DietStatus(
      totalProtein: 45,
      totalFat: 85,
      totalCarbo: 120,
      targetProtein: 100,
      targetFat: 45,
      targetCarbo: 200,
      characterMessage: "おいおい、脂質が目標の2倍近くになってるぞ。油のプールにでも飛び込んだのか？明日の体重計が楽しみだな！",
    );
  }

  // 食事（PFC）を追加するメソッド
  void addDiet(int protein, int fat, int carbo) {
    final newProtein = state.totalProtein + protein;
    final newFat = state.totalFat + fat;
    final newCarbo = state.totalCarbo + carbo;

    // 状態に応じて毒舌メッセージを動的に変化させる
    String newMessage = "よしよし、順調に栄養を補給したな。";
    if (newFat > state.targetFat * 1.5) {
      newMessage = "ギブアップ！これ以上脂質を増やすなら、揚げ物の衣にでも包まって出直してこい！";
    } else if (newProtein < state.targetProtein) {
      newMessage = "タンパク質がまだまだ足りないぞ！筋肉が泣いているのが聞こえないのか？";
    }

    //新しい状態に更新
    state = DietStatus(
      totalProtein: newProtein,
      totalFat: newFat,
      totalCarbo: newCarbo,
      targetProtein: state.targetProtein,
      targetFat: state.targetFat,
      targetCarbo: state.targetCarbo,
      characterMessage: newMessage,
    );
  }
}

// プロバイダーの定義（NotifierProviderを使用）
final dietStatusProvider = NotifierProvider<DietNotifier, DietStatus>(() {
  return DietNotifier();
});
