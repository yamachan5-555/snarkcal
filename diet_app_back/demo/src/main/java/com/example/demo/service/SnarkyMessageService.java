package com.example.demo.service;

import com.example.demo.entity.SnarkyMessage;
import com.example.demo.repository.SnarkyMessageRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Service
public class SnarkyMessageService {
    private final SnarkyMessageRepository snarkyMessageRepository;

   public SnarkyMessageService(SnarkyMessageRepository snarkyMessageRepository) {
       this.snarkyMessageRepository = snarkyMessageRepository;
   }

   /**
    * 実績と目標から最も乖離している栄養素を特定し、毒舌メッセージを取得する
    *
    * @param currentCal 摂取カロリー
    * @param targetCal 目標カロリー
    * @param currentProtein 摂取タンパク質(g)
    * @param targetProtein 目標タンパク質(g)
    * @param currentFat 摂取脂質(g)
    * @param targetFat 目標脂質(g)
    * @param currentCarbo 摂取炭水化物(g)
    * @param targetCarbo 目標炭水化物(g)
    * @return 選定された毒舌メッセージ
    */
   public String generateMessage(
           int currentCal, int targetCal,
           double currentProtein, double targetProtein,
           double currentFat, double targetFat,
           double currentCarbo, double targetCarbo
   ) {
       // 1. 各栄養素の乖離度（目標からのずれ）を判定
       NutrientEvaluation priorityEvaluation = evaluateMostDeviatedNutrient(
               currentCal, targetCal,
               currentProtein, targetProtein,
               currentFat, targetFat,
               currentCarbo, targetCarbo
       );

       // 2. すべて正常範囲内の場合
       if (priorityEvaluation == null) {
           return "珍しく目標通りですね。つまらないですけど、褒めておきます。";
       }

       // 3. DBから該当するメッセージリストを取得
       List<SnarkyMessage> messages = snarkyMessageRepository.findByNutrientTypeAndStatusType(
               priorityEvaluation.nutrientType,
               priorityEvaluation.statusType
       );

       if (messages.isEmpty()) {
           return "しっかり栄養管理してくださいね。";
       }

       // 4. ランダムに1件選択して返却
       int randomIndex = ThreadLocalRandom.current().nextInt(messages.size());
       return messages.get(randomIndex).getMessageText();
   }

   /**
    * 最も目標からの乖離度が大きい栄養素とステータスを特定する内部クラス・ロジック
    */
   private NutrientEvaluation evaluateMostDeviatedNutrient(
           int currentCal, int targetCal,
           double currentProtein, double targetProtein,
           double currentFat, double targetFat,
           double currentCarbo, double targetCarbo
   ) {
       NutrientEvaluation maxDeviated = null;
       double maxDiffRatio = 0.0;

       // 判定対象データの定義 (タイプ, 実績, 目標)
       NutrientData[] dataList = new NutrientData[]{
               new NutrientData("CALORIE", currentCal, targetCal),
               new NutrientData("PROTEIN", currentProtein, targetProtein),
               new NutrientData("FAT", currentFat, targetFat),
               new NutrientData("CARB", currentCarbo, targetCarbo)
       };

       for (NutrientData data : dataList) {
           if (data.target <= 0) continue;

           double ratio = data.current / data.target;
           // 80%未満を不足(DEFICIT)、120%超を超過(SURPLUS)と判定
           if (ratio < 0.8 || ratio > 1.2) {
               double diffRatio = Math.abs(ratio - 1.0);
               if (diffRatio > maxDiffRatio) {
                   maxDiffRatio = diffRatio;
                   String status = (ratio > 1.2) ? "SURPLUS" : "DEFICIT";
                   maxDeviated = new NutrientEvaluation(data.type, status);
               }
           }
       }

       return maxDeviated;
   }

   private static class NutrientData {
       String type;
       double current;
       double target;

       NutrientData(String type, double current, double target) {
           this.type = type;
           this.current = current;
           this.target = target;
       }
   }

   private static class NutrientEvaluation {
       String nutrientType;
       String statusType;

       NutrientEvaluation(String nutrientType, String statusType) {
           this.nutrientType = nutrientType;
           this.statusType = statusType;
       }
   }
}