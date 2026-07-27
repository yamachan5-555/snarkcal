package com.example.demo.controller;

import com.example.demo.entity.Food;
import com.example.demo.repository.FoodRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/foods")
@CrossOrigin(origins = "*") // Flutterからの通信を許可
public class FoodController {

    private final FoodRepository foodRepository;

    public FoodController(FoodRepository foodRepository) {
        this.foodRepository = foodRepository;
    }

    // キーワード検索 API (例: GET /api/v1/foods/search?query=ささみ)
    @GetMapping("/search")
    public List<Food> searchFoods(@RequestParam(name = "query", defaultValue = "") String query) {
        if (query.isEmpty()) {
            return foodRepository.findAll(); // クエリが空なら全件返却
        }
        return foodRepository.findByNameContaining(query);
    }
}