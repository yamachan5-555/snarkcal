package com.example.demo.controller;

import com.example.demo.dto.FoodItemResponse;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/v1/foods")
@CrossOrigin // ★Flutter(Web)からのアクセスを許可
public class FoodController {

    // 動作確認用のダミー食品データベース
    private static final List<FoodItemResponse> DUMMY_FOODS = List.of(
        new FoodItemResponse(1L, "鶏ささみ (生/100g)", 105, 23.0, 0.8, 0.0, 0.1),
        new FoodItemResponse(2L, "サラダチキン (プレーン/100g)", 115, 24.0, 1.5, 0.3, 1.2),
        new FoodItemResponse(3L, "鶏胸肉 皮なし (100g)", 108, 22.3, 1.5, 0.0, 0.1),
        new FoodItemResponse(4L, "白米 (茶碗1杯/150g)", 234, 3.8, 0.5, 55.7, 0.0),
        new FoodItemResponse(5L, "プロテインシェイク (1食)", 120, 20.0, 1.2, 3.0, 0.3)
    );

    @GetMapping("/search")
    public List<FoodItemResponse> searchFoods(@RequestParam(name = "query", defaultValue = "") String query) {
        // 検索キーワードが空の場合は空のリストを返す
        if (query == null || query.trim().isEmpty()) {
            return List.of();
        }

        // キーワードに一致する食品をフィルタリング
        List<FoodItemResponse> results = new ArrayList<>();
        for (FoodItemResponse food : DUMMY_FOODS) {
            if (food.name().contains(query)) {
                results.add(food);
            }
        }

        return results;
    }
}