// 既存:
// int currentCal = 1000;
// int targetCal = 2000;
// ... (モック値)

// 変更後:
package com.example.demo.controller;

import com.example.demo.dto.DailyNutritionResponse;
import com.example.demo.entity.User;
import com.example.demo.repository.FoodRecordRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.SnarkyMessageService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/nutrition")
public class DailyNutritionController {

    private final SnarkyMessageService snarkyMessageService;
    private final FoodRecordRepository foodRecordRepository;
    private final UserRepository userRepository;

    public DailyNutritionController(
            SnarkyMessageService snarkyMessageService,
            FoodRecordRepository foodRecordRepository,
            UserRepository userRepository
    ) {
        this.snarkyMessageService = snarkyMessageService;
        this.foodRecordRepository = foodRecordRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/daily")
    public ResponseEntity<DailyNutritionResponse> getDailyNutrition(
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(value = "userId", defaultValue = "1") Long userId
    ) {
        // 1. ユーザー目標値の取得 (デフォルトユーザーID: 1)
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));

        int targetCal = user.getTargetCalories();
        double targetProtein = user.getTargetProtein();
        double targetFat = user.getTargetFat();
        double targetCarbo = user.getTargetCarbo();

        // 2. 指定日の摂取実績値をDBから集計
        int currentCal = foodRecordRepository.sumCaloriesByUserIdAndDate(userId, date);
        double currentProtein = foodRecordRepository.sumProteinByUserIdAndDate(userId, date);
        double currentFat = foodRecordRepository.sumFatByUserIdAndDate(userId, date);
        double currentCarbo = foodRecordRepository.sumCarboByUserIdAndDate(userId, date);

        // 3. 判定ロジックを実行し、毒舌メッセージを生成
        String snarkyMessage = snarkyMessageService.generateMessage(
                currentCal, targetCal,
                currentProtein, targetProtein,
                currentFat, targetFat,
                currentCarbo, targetCarbo
        );

        DailyNutritionResponse response = new DailyNutritionResponse(
                date,
                snarkyMessage,
                currentCal, targetCal,
                currentProtein, targetProtein,
                currentFat, targetFat,
                currentCarbo, targetCarbo
        );

        return ResponseEntity.ok(response);
    }
}